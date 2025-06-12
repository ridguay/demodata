### 0. prerequisites

## install az cli:
# pip install azcli

## install az devops extension:
# az extension add --name azure-devops

## install jq to parse azcli JSON output
# winget install jqlang.jq

### 1. Parameters, fill these in first!
project_name="LPDAP_Mall RRT"
project_desc="LPDAP Reinsurance (RRT) mall team which is responsible for delivering Gold Layer Objects."
project_org="https://dev.azure.com/NN-Life-Pensions/"
team_abbrev="rrt"
default_team_name="${project_name} Team"
engineers_team_name="RRT Data Engineers"
engineers_team_desc="CPA accounts of all engineers"
platform_team_name="LPDAP_Platform Team"
platform_team_desc="The LPDAP Platform Team."
repo_name="transformation"
source_project="LPDAP_Mall BDT"
source_team_abbrev="bdt"
repo_source_url="https://NN-Life-Pensions@dev.azure.com/NN-Life-Pensions/LPDAP_Mall%20BDT/_git/transformation"
repo_target_url="https://NN-Life-Pensions@dev.azure.com/NN-Life-Pensions/LPDAP_Mall%20RRT/_git/transformation"

# Don't run all the commands all at once. Run them one-by-one, and make sure you know what you're doing!
exit 0

### 2. Creating the Azure Devops project
## Log into Azure DevOps if you haven't done so yet. 
## You will be asked to fill in a PAT, create one for your corporate key (!) with full access permisions.
az devops login

## Create a new project
# az devops project create --name $project_name --description $project_desc --org $project_org
az devops project create --name "$project_name" --description "$project_desc" --org "$project_org"

# Optionally, set the defaults for organization and project so we don't have to keep repeating them
az devops configure --defaults organization="$project_org" project="$project_name"

## Create the LPDAP platform team
az devops team create --name "$platform_team_name" --description "$platform_team_desc" --project "$project_name"

## TODO: At this point, manually add the Platform team's CPA accounts to this team.
## As of 2025-05-14, there is no way to do this via the azcli: https://learn.microsoft.com/en-us/azure/devops/organizations/security/add-users-team-project?view=azure-devops&tabs=preview-page#list-team-members-or-team-details

# Also create the Mall engineer team (which is a Security Group, not an actual team)
az devops security group create --name "$engineers_team_name" --description "$engineers_team_desc"
## TODO: manually add the Mall engineers' CPA accounts to this team
## We will need this later to set the reviewer policies


### 3. Setting up the transformation repo
## Create the repo in the target project
az repos create --name "$repo_name" --org "$project_org" --project "$project_name"

## Clone transformation locally from another project, update the remote, then push back
git clone $repo_source_url
cd $repo_name
git remote set-url origin $repo_target_url

### 3.1 Go into the repo and update all source project references to the target project
cd cicd/
for file in *; do
    echo $file
    sed -i "s/$source_project/$project_name/g" $file
done
cd ../

# Also find and replace all three-letter source team abbreviation references
find ./cicd/ -type f -exec sed -i "s/domain: ${source_team_abbrev}/domain: ${team_abbrev}/" {} +

# Also remove everything from the repo that's not the bundle file (reset to clean state)
find src/$repo_name -mindepth 1 ! -name 'bundle.yml' -exec rm -rf {} +

## TODO: add step that updates Databricks workspace URLs here!
## TODO: do manually for now, maybe improve via jq / asset bundle template later.
# dbw_url_sbx=""
# dbw_url_pdv=""
# dbw_url_dev=""
# dbw_url_tst=""
# dbw_url_acc=""
# dbw_url_prd=""

### 3.2 Set up Poetry and semantic-release
## Reset the config to the default for this team
sed -i "s/^name = .*/name = \"$repo_name-$team_abbrev\"/" pyproject.toml
sed -i "s/^version = .*/version = \"0.0.1\"/" pyproject.toml
sed -i "s/^description = .*/description = \"Transformation repository for $project_name\"/" pyproject.toml

## Reset the CHANGELOG to an empty file
rm CHANGELOG.md
touch CHANGELOG.md

### 3.3 Commit the changes and push the result directly to develop (yolo)
git checkout --orphan develop-clean
git add .
git commit -m "Initial commit"
git branch -u origin/develop develop-clean
git push origin HEAD:develop -f


### 4. Azure Pipelines
## Create the CICD pipeline definitions based on the local files we just updated
pipelines=(feature-push feature-pr feature-complete validate-pr generate-tag deploy-asset-bundle)
for pipe in "${pipelines[@]}"; do
    az pipelines create \
        --name "$pipe" \
        --folder-path "$repo_name" \
        --yaml-path "cicd/${pipe}.yml" \
        --description "$pipe pipeline for $repo_name" \
        --repository "$repo_name" \
        --repository-type tfsgit \
        --branch develop \
        --skip-first-run true
done

# Remove the local directory
cd ..
rm -rf $repo_name

### 5. Create repository policies
## Find the repository id first, will need this for all subsequent commands
repository_id=$(az repos show --repository "$repo_name" --org "$project_org" --project "$project_name" | jq -r ".id")

## Set develop as default and compare branch
## Add reviewer policy
az repos policy approver-count create \
    --allow-downvotes false \
    --blocking true \
    --branch develop \
    --creator-vote-counts false \
    --enabled true \
    --minimum-approver-count 1 \
    --repository-id "$repository_id" \
    --reset-on-source-push true \
    --branch-match-type exact \
    --org "$project_org" \
    --project "$project_name"

## Enforce comment resolution
az repos policy comment-required create \
    --blocking true \
    --branch develop \
    --enabled true \
    --repository-id "$repository_id" \
    --branch-match-type exact \
    --org "$project_org" \
    --project "$project_name"

## Limit merge types to squash only
az repos policy merge-strategy create \
    --blocking true \
    --branch develop \
    --repository-id "$repository_id" \
    --allow-squash true \
    --enabled true \
    --branch-match-type exact \
    --org "$project_org" \
    --project "$project_name"

## Enforce review by one of the team's engineers
az repos policy required-reviewer create \
    --blocking true \
    --branch develop \
    --repository-id "$repository_id" \
    --path-filter '!/cicd/*' \
    --message "Team reviewer required" \
    --required-reviewer-ids "[$project_name]\\$engineers_team_name" \
    --enabled true

# Enforce review by Platform team when changing cicd
az repos policy required-reviewer create \
    --blocking true \
    --branch develop \
    --repository-id "$repository_id" \
    --path-filter "/cicd/*" \
    --message "CICD changes must be approved by the platform team" \
    --required-reviewer-ids "[LPDAP_Azure]\DataOps engineers" \
    --enabled true

### 6. Set up Build pipelines and policies

# TODO: Add (linked) agent pools manually first! No way to automate this seemingly :(

### 6.1 Add build policies
# Find build definition IDs first, pipelines have already been created above during repo setup
feature_pr_id=$(az pipelines build definition list --name "feature-pr" | jq -r ".[0].id")
validate_pr_id=$(az pipelines build definition list --name "validate-pr" | jq -r ".[0].id")

# feature-pr policy
az repos policy build create \
    --blocking true \
    --branch develop \
    --build-definition-id $feature_pr_id \
    --display-name "feature-pr" \
    --enabled true \
    --manual-queue-only false \
    --queue-on-source-update-only false \
    --repository-id $repository_id \
    --valid-duration 0\
    --path-filter "/src/*"

# validate-pr policy
az repos policy build create \
    --blocking true \
    --branch develop \
    --build-definition-id $validate_pr_id \
    --display-name "validate-pr" \
    --enabled true \
    --manual-queue-only false \
    --queue-on-source-update-only false \
    --repository-id $repository_id \
    --valid-duration 0

### 6.2 Create environments
# TODO: Create Azure Pipeline environments manually because the API endpoint does not work :)
# create databricks-dev, databricks-tst, databricks-acc, databricks-prd.
# add approval gate to databricks-prd for Mall engineers team.

### 6.2 Service connections
# TODO: Create service connections for IAM manually
# Go to LPDAP_Azure and select the IAM service connections.
# Under the ..., select Security and give the Project permissions to use the Shared service connection
# Then go to target project and update the name (trim off everything after the env code)
# Finally, go to each service connection > Security > Pipeline permissions and assign the following permissions:
# IAM-DEV: feature-push, feature-pr, deploy-asset-bundle 
# IAM-TST: feature-complete, feature-pr, deploy-asset-bundle
# IAM-ACC: deploy-asset-bundle
# IAM-PRD: deploy-asset-bundle

# Also create sp-lpdap-meta, get the key from client-secret-meta in meta kv
# TODO: manually give access to all project pipelines
az devops service-endpoint azurerm create \
    --azure-rm-service-principal-id 3e76b4bb-79aa-479b-98d4-1d053cf883e7 \
    --azure-rm-subscription-id 8e5fbe4b-a78e-4e74-b38c-15f7fbe4cf9b \
    --azure-rm-subscription-name LPDAP-META \
    --azure-rm-tenant-id fed95e69-8d73-43fe-affb-a7d85ede36fb \
    --name sp-lpdap-meta

### 6.3 Misc. other changes
# Create variable group with username for Semantic Release
az pipelines variable-group create \
    --name "Azure DevOps PAT Semantic Release" \
    --description "Azure DevOps PAT used by Semantic Release to be able to commit changes to the CHANGELOG.md" \
    --variables DEV_OPS_USER_NAME=QL80AV

# TODO: give Agent pool permissions
# TODO: give pipelines permissions to cicd repo
# TODO: give pipelines permissions to IAM repo
# TODO: allow bypass policy when pushing from Menno's account (QL80AV) to develop
# TODO: in project settings, under Pipelines > Settings, set the following settings:
# TODO: Limit job authorization scope to current project for non-release pipelines > Off
# TODO: Protect access to repositories in YAML pipelines > Off
# TODO: Limit building pull requests from forked GitHub repositories > On
# Always start by ensuring the tfstate directories are empty (tfstate_backup, input, output)
# Also, ensure you're running this script from the main infra-modules directory!
rm -r ./utils/merge_tfstates/input/*
rm -r ./utils/merge_tfstates/output/*
rm -r ./utils/merge_tfstates/tfstate_backup/*
New-Item -Path ./utils/merge_tfstates/input/.gitkeep -ItemType File
New-Item -Path ./utils/merge_tfstates/output/.gitkeep -ItemType File
New-Item -Path ./utils/merge_tfstates/tfstate_backup/.gitkeep -ItemType File

# First, download the current tfstate files for a given env and product
# Ensure you've used `az login` to connect to the meta subscription before running this command
$env="sbx"
$domain="customer_workflow"
$product_type="domain"
az storage blob download-batch --destination utils/merge_tfstates/tfstate_backup/ --source $env --pattern $domain/*.tfstate --account-name stlpdapv001metatfstate

# Copy them to the input directory (ensure it's empty before you start)
cp -R utils/merge_tfstates/tfstate_backup/$domain/* utils/merge_tfstates/input/

# Optionally, back them up on the meta storage account
az storage blob upload-batch --destination tfstate-backup/$env --source utils/merge_tfstates/tfstate_backup/ --account-name stlpdapv001metatfstate --overwrite

# Then run the Python file to merge the tfstate files (ensure you run this from the infra-modules/ directory!)
python ./utils/merge_tfstates/merge-tfstate-files.py $product_type $env

# Manually confirm you're only uploading correct output to base/functional/operational directories to prevent breaking the env
exit

# Now upload the merged tfstate files to the tfstate bucket
# TODO this feels dangerous... kept the overwrite flag out now to prevent issues, but will need to revisit this
# This should not overwrite in any other environment than sbx!
# TODO add conditional overwrite based on env
$overwrite="--overwrite"
# if [ $env != "sbx" ]; then
#   $overwrite=""
# fi
az storage blob upload-batch --destination $env/$domain --source utils/merge_tfstates/output --account-name stlpdapv001metatfstate $overwrite --dryrun

# Test by running terragrunt run-all plan on the `base`, `functional` and `operational` folders
cd terraform/products/domain/functional_new/
terragrunt run-all plan --terragrunt-ignore-external-dependencies

# cd ../../../../../

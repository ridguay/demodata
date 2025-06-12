## Deploy

We assume there is an image deployed to the Azure Container Registry,
and will now use Terragrunt and Terraform to take that image from the Azure Container Registry
and deploy it as a Container Instances such that functions as a build agent.

1. Create a personal access token in Azure DevOps.  
   Go to `User Settings`, `Personal Access Token` and add one (if you don't have one yet).
2. Navigate to the `/terraform/agents/` directory.  
3. Create a `secrets.yaml` file inside that directory containing the following values:
   ```YAML
   client_secret: "<Meta Client Secret>"
   devops_personal_access_token: "<DevOps PAT>"
   ```
   __This file should be next to the `environment.yaml` file.


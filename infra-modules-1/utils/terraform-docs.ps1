# Utils script to update README.md file for all Terraform Modules by running "utils\terraform-docs.ps1"

$root=$PWD

#Get-ChildItem $root -Recurse -Filter *main.tf | 
Get-ChildItem $root -Recurse -Exclude "*.terragrunt-cache*" -Filter "*main.tf" -ErrorAction SilentlyContinue |
Foreach-Object {
  if (!$_.FullName.Contains(".terragrunt-cache")){
    cd $(Split-Path -parent $_.FullName)
    terraform-docs markdown table --config $root/terraform-docs.yml .
  }
}
cd $root

git status --porcelain

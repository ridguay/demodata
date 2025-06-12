# Utils script to update README.md file for all Terraform Modules by running "utils\terraform-docs.sh"

root=$PWD
for path in $(find terraform/ -type f -name "main.tf"); do
  dir_path=$(echo $path | awk '{ print substr( $0, 1, length($0)-8 ) }')
  cd $root/$dir_path
  terraform-docs markdown table --config $root/terraform-docs.yml .
done


if [[ $(git status --porcelain) ]]; then
  echo 'Terraform modules documentation updated for:'
  # Use grep to only show files starting with 'terraform/' and ending in '/Readme.md'
  git status --porcelain | grep ".*terraform/.*/README.md"
fi

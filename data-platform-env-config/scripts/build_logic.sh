#!/bin/bash
# Script to build the artifact for the ingestion logic.
# Generally, this is the artifact created with the help of the data-logic-core dependency.
# This is used in the release process of the ingestion repositories.

# Explicitly cause this script to fail if any command raises an error code
set -Eeuo pipefail

# Directory to store the logic artifact in. If it exists it will be removed first to clean up previous runs.
parameters_target_directory=$1

# Filter for the sources of which the SLO's should be included. When '*', all sources will be built.
parameters_source_directory_filter=$2

echo "target directory: ${parameters_target_directory}"
echo "#############"
echo ""

echo "##[command]poetry install --without dev --without data-pipeline-core"
poetry install --without dev --without data-pipeline-core

echo "Clear target directory"
echo "##[command]rm -rf ${parameters_target_directory}"
rm -rf ${parameters_target_directory}

echo "Clear dist directory"
echo "##[command]rm -rf dist"
rm -rf "dist"

echo "##[command]poetry build --format=wheel"
poetry build --format=wheel

echo "##[command]mkdir ${parameters_target_directory}"
mkdir ${parameters_target_directory}

echo "##[command]cp -r dist ${parameters_target_directory}/dist"
cp -r dist ${parameters_target_directory}/dist

echo "##[command]mkdir ${parameters_target_directory}/src"
mkdir ${parameters_target_directory}/src

echo "##[command]mkdir ${parameters_target_directory}/src/ingestion"
mkdir ${parameters_target_directory}/src/ingestion

echo "##[command]mkdir ${parameters_target_directory}/src/ingestion/sources"
mkdir ${parameters_target_directory}/src/ingestion/sources

echo "Copy all notebooks directly in the src directory of the data-logic-core"
for file_path in data-logic-core/src/*.py; do
    echo "##[command]cp -r $file_path ${parameters_target_directory}/${file_path#data-logic-core/}"
    cp -r $file_path ${parameters_target_directory}/${file_path#data-logic-core/}
done

# Copy all files matching `./src/ingestion/sources/*/slo/**` to the target directory preserving the directory structure
echo "##[command]find . -wholename \"./src/ingestion/sources/${parameters_source_directory_filter}/slo/**\" -exec cp --parents {} temp \;"
find . -wholename "./src/ingestion/sources/${parameters_source_directory_filter}/slo/**" -exec cp --parents {} ${parameters_target_directory} \;

echo "##[command]cp -r data-logic-core/terraform ${parameters_target_directory}/terraform"
cp -r data-logic-core/terraform ${parameters_target_directory}/terraform

# Copy all custom notebooks to the notebooks destination directory
echo "##[command]mkdir ${parameters_target_directory}/terraform/databricks_custom_notebooks/notebooks"
mkdir ${parameters_target_directory}/terraform/databricks_custom_notebooks/notebooks

# Create dummy file
echo "##[command] touch ${parameters_target_directory}/terraform/databricks_custom_notebooks/notebooks/dir_exist.init"
touch ${parameters_target_directory}/terraform/databricks_custom_notebooks/notebooks/dir_exist.init

echo "##[command][ -d "./src/ingestion/notebooks" ] && find ./src/ingestion/notebooks \( -name \"*.py\" -o -name \"*.sql\" \) -exec cp {} ${parameters_target_directory}/terraform/databricks_custom_notebooks/notebooks \;"
[ -d "./src/ingestion/notebooks" ] && find ./src/ingestion/notebooks \( -name "*.py" -o -name "*.sql" \) -exec cp {} ${parameters_target_directory}/terraform/databricks_custom_notebooks/notebooks \;

# Copy all custom files to the files destination directory
echo "##[command]mkdir ${parameters_target_directory}/terraform/databricks_custom_notebooks/files"
mkdir ${parameters_target_directory}/terraform/databricks_custom_notebooks/files

echo "##[command][ -d "./src/ingestion/files" ] && find ./src/ingestion/files \( -name \"*.py\" -o -name \"*.sql\" \) -exec cp {} ${parameters_target_directory}/terraform/databricks_custom_notebooks/files \;"
[ -d "./src/ingestion/files" ] && find src/ingestion/files \( -name "*.py" -o -name "*.sql" \) -exec cp {} ${parameters_target_directory}/terraform/databricks_custom_notebooks/files \;

# Create dummy file
echo "##[command] touch ${parameters_target_directory}/terraform/databricks_custom_notebooks/files/dir_exist.init"
touch ${parameters_target_directory}/terraform/databricks_custom_notebooks/files/dir_exist.init

echo "##[command]cp -r data-logic-core/databricks_asset_bundles_template ${parameters_target_directory}/databricks_asset_bundles_template"
cp -r data-logic-core/databricks_asset_bundles_template ${parameters_target_directory}/databricks_asset_bundles_template

echo "##[command]cp -r data-logic-core/databricks_asset_bundles_template_v2 ${parameters_target_directory}/databricks_asset_bundles_template_v2"
cp -r data-logic-core/databricks_asset_bundles_template_v2 ${parameters_target_directory}/databricks_asset_bundles_template_v2

echo "##[command]poetry version -C data-logic-core"
poetry version -C data-logic-core

echo "##[command]poetry version -C data-logic-core > ${parameters_target_directory}/version.txt"
poetry version -C data-logic-core > ${parameters_target_directory}/version.txt

exit 0

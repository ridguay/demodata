#!/bin/bash
# Script to build the artifact for the ADF pipeline payloads.
# Generally, this is the artifact created with the help of the data-pipeline-core dependency.
# This is used in the release process of the ingestion repositories.

# Explicitly cause this script to fail if any command raises an error code
set -Eeuo pipefail

# Environments to build the payload of. Should be space separated.
parameters_environments=$1

# Directory to store the payloads in. If it exists it will be removed first to clean up previous runs.
parameters_target_directory=$2

# Filter for the sources of which the payload should be built. When '*', all sources will be built.
parameters_source_directory_filter=$3


echo "environments: ${parameters_environments}"
echo "target directory: ${parameters_target_directory}"
echo "source directory filter: ${parameters_source_directory_filter}"

echo "#############"
echo ""

echo "##[command]pip3 install --upgrade requests"
pip3 install --upgrade requests

echo "##[command]pip install poetry==1.5.1"
pip install poetry==1.5.1

echo "##[command]pip install packaging==22.0"
pip install packaging==22.0

echo "##[command]poetry install --without dev --without data-logic-core"
poetry install --without dev --without data-logic-core

echo "Clear target directory"
echo "##[command]rm -rf ${parameters_target_directory}"
rm -rf ${parameters_target_directory}

echo "Clear payload directory"
echo "##[command]rm -rf payload"
rm -rf "payload"

for d in src/ingestion/sources/${parameters_source_directory_filter}/; do
    for env in ${parameters_environments}; do
        echo "##[group]Create Payloads: $d - $env"

        echo "##[command]export ENVIRONMENT=\"$env\""
        export ENVIRONMENT="$env"

        echo "##[command]poetry run python ${d}pipelines.py"
        poetry run python ${d}pipelines.py

        echo "##[endgroup]"
    done
done

echo "##[command]mkdir ${parameters_target_directory}"
mkdir ${parameters_target_directory}

echo "##[command]cp -r payload ${parameters_target_directory}/payload"
cp -r payload ${parameters_target_directory}/payload

echo "##[command]rm -rf payload"
rm -rf "payload"

echo "##[command]cp -r data-pipeline-core/terraform ${parameters_target_directory}/terraform"
cp -r data-pipeline-core/terraform ${parameters_target_directory}/terraform

echo "##[command]poetry version -C data-pipeline-core"
poetry version -C data-pipeline-core

echo "##[command]poetry version -C data-pipeline-core > ${parameters_target_directory}/version.txt"
poetry version -C data-pipeline-core > ${parameters_target_directory}/version.txt

exit 0
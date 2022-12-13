#!/usr/bin/env bash

set -eu
export DOCKER_DEFAULT_PLATFORM=linux/amd64

function runTerraformValidate() {
  echo "Running Terraform Validate in ${1}..."
  export TF_DATA_DIR="/data/build/pre-commit/${1}"

  docker run \
    -v "$(pwd):/data" \
    -e TF_DATA_DIR \
    -e TF_IN_AUTOMATION=1 \
    "hashicorp/terraform:${TF_VERSION}" \
    -chdir="/data/${1}" \
    init -backend=false

  docker run \
    -v "$(pwd):/data" \
    -e TF_DATA_DIR \
    -e TF_IN_AUTOMATION=1 \
    "hashicorp/terraform:${TF_VERSION}" \
    -chdir="/data/${1}" \
    validate
}

for DIR in $(echo "$@" | xargs -n1 dirname | sort -u | uniq); do

  if [[ -f "${DIR}/.terraform-version" ]]; then
    TF_VERSION="$(cat "${DIR}/.terraform-version")"
  elif [[ -f "${DIR}/../.terraform-version" ]]; then
    TF_VERSION="$(cat "${DIR}/../.terraform-version")"
  else
    TF_VERSION="latest"
  fi

  runTerraformValidate "${DIR}"
done


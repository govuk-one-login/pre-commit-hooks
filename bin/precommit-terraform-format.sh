#!/usr/bin/env bash
set -e
export DOCKER_DEFAULT_PLATFORM="linux/amd64"

for DIR in $(echo "$@" | xargs -n1 dirname | sort -u | uniq); do
  TF_VERSION="latest"
  if [[ -f "${DIR}/../.terraform-version" ]]; then
    TF_VERSION="$(cat "${DIR}/../.terraform-version")"
  fi
  if [[ -f "${DIR}/.terraform-version" ]]; then
    TF_VERSION="$(cat "${DIR}/.terraform-version")"
  fi
  echo "Running terraform fmt in ${DIR}..."
  docker run --rm -v "$(pwd):/data" -t \
    -e TF_IN_AUTOMATION=1 \
    "hashicorp/terraform:${TF_VERSION}" \
    -chdir="/data/${DIR}" \
    fmt
done

#!/usr/bin/env bash

set -e

args=$(./scripts/codeartifactory-args.sh "$@")
IFS=',' read -r -a args <<< "$args"
domain="${args[0]}";repository="${args[1]}"

CODEARTIFACT_USER=aws
CODEARTIFACT_REPOSITORY_URL=$(aws codeartifact get-repository-endpoint --domain ${domain} --repository ${repository} --format pypi --output text)
CODEARTIFACT_TOKEN=$(aws codeartifact get-authorization-token --domain ${domain} --query authorizationToken --output text)

echo "${CODEARTIFACT_REPOSITORY_URL},${CODEARTIFACT_USER},${CODEARTIFACT_TOKEN}"

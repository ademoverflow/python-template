#!/usr/bin/env bash

PACKAGE_NAME=python-template

# Prepare codeartifactory parameters
args=$(./scripts/codeartifact/args.sh "$@")
IFS=',' read -r -a args <<< "$args"
domain="${args[0]}";repository="${args[1]}"
info=$(bash scripts/codeartifact/get-info.sh --domain ${domain} --repository ${repository})
IFS=',' read -r -a info <<< "$info"
repository_url="${info[0]}";user="${info[1]}";token="${info[2]}"

# Configure poetry
poetry config repositories.${PACKAGE_NAME} ${repository_url}
poetry config http-basic.${PACKAGE_NAME} ${user} ${token}

# Build and publish to AWS Code Artifact
poetry build
poetry publish -r ${PACKAGE_NAME}
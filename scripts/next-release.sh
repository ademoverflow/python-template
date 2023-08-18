#!/usr/bin/env bash

PACKAGE_NAME=python-template

# Prepare codeartifactory parameters
args=$(./scripts/codeartifactory-args.sh "$@")
IFS=',' read -r -a args <<< "$args"
domain="${args[0]}";repository="${args[1]}"
info=$(bash scripts/get-codeartifact-info.sh --domain ${domain} --repository ${repository})
IFS=',' read -r -a info <<< "$info"
repository_url="${info[0]}";user="${info[1]}";token="${info[2]}"

# Configure GIT user
git config --global user.name "github-actions"
git config --global user.email "action@github.com"

# Get next version
VERSION=$(poetry run semantic-release print-version)
echo "Publishing next release ${VERSION} on GitHub ..."
poetry run semantic-release publish

# Re Pull from master branch
git pull origin master

# Configure poetry
echo "Publishing next release ${VERSION} on AWS Code Artifact ..."
poetry config repositories.${PACKAGE_NAME} ${repository_url}
poetry config http-basic.${PACKAGE_NAME} ${user} ${token}

# Build and publish to AWS Code Artifact
poetry build
poetry publish -r ${PACKAGE_NAME}
#!/usr/bin/env bash

# Configure GIT user
git config --global user.name "github-actions"
git config --global user.email "action@github.com"

# Get next version
VERSION=$(poetry run semantic-release print-version)
echo "Publishing next release ${VERSION} on GitHub ..."
poetry run semantic-release publish

# Re Pull from master branch
git pull origin master

# Get AWS Code Artifact Info and token:
echo "Publishing next release ${VERSION} on AWS Code Artifact ..."
DOMAIN=antipodestudios
REPOSITORY=antipodestudios
CODEARTIFACT_REPOSITORY_URL=$(aws codeartifact get-repository-endpoint --domain ${DOMAIN} --repository ${REPOSITORY} --format pypi --output text)
CODEARTIFACT_AUTH_TOKEN=$(aws codeartifact get-authorization-token --domain ${DOMAIN} --query authorizationToken --output text)
CODEARTIFACT_USER=aws

# Configure poetry
PACKAGE_NAME=python-template
poetry config repositories.${PACKAGE_NAME} ${CODEARTIFACT_REPOSITORY_URL}
poetry config http-basic.${PACKAGE_NAME} ${CODEARTIFACT_USER} ${CODEARTIFACT_AUTH_TOKEN}

# Build and publish to AWS Code Artifact
echo "Building ${PACKAGE_NAME} ..."
poetry build
echo "Publishing ${PACKAGE_NAME} to AWS ..."
poetry publish -r ${PACKAGE_NAME}
echo "DONE !"
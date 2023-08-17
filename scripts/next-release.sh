#!/usr/bin/env bash

git config --global user.name "github-actions"
git config --global user.email "action@github.com"

VERSION=$(poetry run semantic-release print-version)
echo "Publishing next release ${VERSION} ..."

${PACKAGE_NAME} poetry run semantic-release publish
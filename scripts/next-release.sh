#!/usr/bin/env bash

git config --global user.name "github-actions"
git config --global user.email "action@github.com"

VERSION=$(semantic-release print-version)
echo "Publishing next release ${VERSION} ..."

${PACKAGE_NAME} semantic-release publish
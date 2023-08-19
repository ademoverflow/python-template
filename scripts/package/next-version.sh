#!/usr/bin/env bash

# Configure GIT user
git config user.name "github-actions"
git config user.email "action@github.com"

# Compute next version and commit 
poetry run semantic-release version --no-vcs-release --skip-build

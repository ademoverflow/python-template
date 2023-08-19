#!/usr/bin/env bash

function prepare_package {
  echo "Generating python $template_type ..."

  # Dev Container file
  mv .devcontainer/devcontainer.package.json .devcontainer/devcontainer.json
  rm .devcontainer/devcontainer.app.json

  # GitHub Actions
  mkdir -p .github/workflows
  mv .github/package/* .github/workflows/
  rmdir .github/package
  rm -rf .github/app

  # Scripts
  mv scripts/package/* scripts/
  rmdir scripts/package
  rm -rf scripts/app

  # Docker Compose
  mv docker-compose.package.yml docker-compose.yml
  rm docker-compose.app.*

  # Docker
  mv Dockerfile.package Dockerfile
  rm Dockerfile.app

  # Makefile
  mv Makefile.package Makefile
  rm Makefile.app

  # Readme
  mv README.package.md README.md
  rm README.app.md
}

function prepare_application {
  echo "Generating python $template_type ..."

  # Dev Container file
  mv .devcontainer/devcontainer.app.json .devcontainer/devcontainer.json
  rm .devcontainer/devcontainer.package.json
  
  # GitHub Actions
  mkdir -p .github/workflows
  mv .github/app/* .github/workflows/
  rmdir .github/app
  rm -rf .github/package

  # Scripts
  mv scripts/app/* scripts/
  rmdir scripts/app
  rm -rf scripts/package

  # Docker Compose
  mv docker-compose.app.dev.yml docker-compose.dev.yml
  mv docker-compose.app.lambda.yml docker-compose.lambda.yml
  mv docker-compose.app.yml docker-compose.yml
  rm docker-compose.package.yml

  # Docker
  mv Dockerfile.app Dockerfile
  rm Dockerfile.package

  # Makefile
  mv Makefile.app Makefile
  rm Makefile.package

  # Readme
  mv README.app.md README.md
  rm README.package.md
}

# -- Choose between package or application:
read -p "Choose your type of template (package, application): " template_type

case $template_type in
  package) prepare_package ;;
  application) prepare_application ;;
  *) echo "Unrecognized template: $template_type" ; exit 1;
esac

# -- Ask for project name
default_project_name=${PWD##*/} 
read -p "Provide a project name (default to ${default_project_name}): " user_project_name

project_name=""
if [[ $user_project_name = "" ]]
then
    project_name=${default_project_name}
else
    project_name=${user_project_name}
fi
echo "Project name will be ${project_name}"
files=$(find . -type f -not -path './.git/*' -exec grep -l "python-template" {} \;)
for file in $files
do
    if [[ $file == *"repo-init.sh"* ]]; then
        continue
    fi
    sed -i "s/python-template/${project_name}/g" $file
done

# -- Ask for a description
read -p "Provide a simple description: " user_description
files=$(find .  -type f -not -path './.venv/*' -not -path './.git/*' -exec grep -l "description-here" {} \;)
for file in $files
do
    if [[ $file == *"repo-init.sh"* ]]; then
        continue
    fi
    sed -i "s/description-here/${user_description}/g" $file
done

# -- Renaming 'python_template' to project_name, replacing '-' with '_' (as the folder will be a python package).
package_name=$(echo "$project_name" | sed 's/-/_/g')
files=$(find . -type f -not -path './.git/*' -exec grep -l "python_template" {} \;)
for file in $files
do
    if [[ $file == *"repo-init.sh"* ]]; then
        continue
    fi
    sed -i "s/python_template/${package_name}/g" $file
done

# -- Removing template codebase
mv src/python_template/__init__.py src/__init__.py # Keep the only code we need
rm -rf src/python_template
mkdir -p src/$package_name
mv src/__init__.py src/$package_name/__init__.py
rm -rf tests/*
touch tests/.keep

# -- Write template version in a .TEMPLATE_VERSION file
grep -m 1 "version = " pyproject.toml | sed 's/.*"\(.*\)".*/\1/' > .TEMPLATE_VERSION
# Reset pyproject.toml version:
sed -i '0,/version = /{s/version = .*/version = "0.0.0"/;}' pyproject.toml

# -- Remove changelog
rm -f CHANGELOG.md
cat > CHANGELOG.md <<EOL
# Changelog

<!--next-version-placeholder-->

EOL

# -- Remove repo-init script:
rm -f ./repository-init.sh

# -- Commit all the changes
# git add --all
# git commit -m "chore: cleanup for template"
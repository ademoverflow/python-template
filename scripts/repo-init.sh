#!/usr/bin/env bash


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

files=$(find .  -type f -not -path './.venv/*' -not -path './.git/*' -exec grep -l "python-template" {} \;)
for file in $files
do
    if [[ $file == *"repo-init.sh"* ]]; then
        continue
    fi
    sed -i "s/python-template/${project_name}/g" $file
done

read -p "Provide a simple description: " user_description
files=$(find .  -type f -not -path './.venv/*' -not -path './.git/*' -exec grep -l "description-here" {} \;)
for file in $files
do
    if [[ $file == *"repo-init.sh"* ]]; then
        continue
    fi
    sed -i "s/description-here/${user_description}/g" $file
done

# Remove last section of README.
sed -i '/## Template usage/,$d' README.md
sed -i '/## Template usage/d' README.md
sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' README.md

# Renaming 'python_template' to project_name, replacing '-' with '_' (as the folder will be a python package).
package_name=$(echo "$project_name" | sed 's/-/_/g')

files=$(find .  -type f -not -path './.venv/*' -not -path './.git/*' -exec grep -l "python_template" {} \;)
for file in $files
do
    if [[ $file == *"repo-init.sh"* ]]; then
        continue
    fi
    sed -i "s/python_template/${package_name}/g" $file
done

echo "Removing all template scripts ..."
rm -rf ./scripts

echo "Removing template codebase ..."
mv src/python_template/__init__.py src/__init__.py # Keep the only code we need
rm -rf src/python_template
mkdir -p src/$package_name
mv src/__init__.py src/$package_name/__init__.py

rm -rf tests/*

# Write template version in a .TEMPLATE_VERSION file
grep -m 1 "version = " pyproject.toml | sed 's/.*"\(.*\)".*/\1/' > .TEMPLATE_VERSION
# Reset pyproject.toml version:
sed -i '0,/version = /{s/version = .*/version = "0.0.0"/;}' pyproject.toml

# Initiating git repository if user wants a git repository
init_git_repository=""
while [[ "$init_git_repository" != "yes" && "$init_git_repository" != "no" ]]; do
  read -p "Do you need to initialize this project as a git repository ? (yes/no): "  init_git_repository
  if [[ "$init_git_repository" != "yes" && "$init_git_repository" != "no" ]]; then
    echo "Please answer with yes  or no."
  fi
done

if [[ "${init_git_repository}" = "yes" ]]
then
    echo "Initializing git repository for ${project_name}"
    git init
    git add --all && git commit -m "feat: first commit for ${project_name}"
else
    echo "Git initialization for the project disabled."
fi



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

files=$(find . -type f -not -path './.git/*' -exec grep -l "python-template" {} \;)
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

files=$(find . -type f -not -path './.git/*' -exec grep -l "python_template" {} \;)
for file in $files
do
    if [[ $file == *"repo-init.sh"* ]]; then
        continue
    fi
    sed -i "s/python_template/${package_name}/g" $file
done


echo "Removing template codebase ..."
mv src/python_template/__init__.py src/__init__.py # Keep the only code we need
rm -rf src/python_template
mkdir -p src/$package_name
mv src/__init__.py src/$package_name/__init__.py

rm -rf tests/*
touch tests/.keep

# Write template version in a .TEMPLATE_VERSION file
grep -m 1 "version = " pyproject.toml | sed 's/.*"\(.*\)".*/\1/' > .TEMPLATE_VERSION
# Reset pyproject.toml version:
sed -i '0,/version = /{s/version = .*/version = "0.0.0"/;}' pyproject.toml

# Remove changelog
rm -f CHANGELOG.md
cat > CHANGELOG.md <<EOL
# Changelog

<!--next-version-placeholder-->

EOL


rm -f ./scripts/repo-init.sh

git add --all
git commit -m "chore: cleanup for template"
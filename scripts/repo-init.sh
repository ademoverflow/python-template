#!/usr/bin/env bash


default_project_name=${PWD##*/} 
echo "Provide a project name (default to ${default_project_name}): "
read user_project_name

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
    sed -i 's/python-template/my-awesome-service/g' $file
done

echo "Provide a simple description: "
read user_description
files=$(find .  -type f -not -path './.venv/*' -not -path './.git/*' -exec grep -l "description-here" {} \;)
for file in $files
do
    if [[ $file == *"repo-init.sh"* ]]; then
        continue
    fi
    sed -i "s/description-here/${user_description}/g" $file
done
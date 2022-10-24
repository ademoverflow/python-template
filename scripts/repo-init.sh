#!/usr/bin/env bash

files=$(find .  -type f -not -path './.venv/*' -not -path './.git/*' -exec grep -l "python-template" {} \;)
for file in $files
do
    if [[ $file == *"repo-init.sh"* ]]; then
        continue
    fi
    sed -i 's/python-template/my-awesome-service/g' $file
done
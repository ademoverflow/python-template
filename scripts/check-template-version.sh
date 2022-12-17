#!/usr/bin/env bash

# Get release name
branch_name=$1
IFS='/'; read -a strarr <<< "${branch_name}"; release=${strarr[-1]}

# Get template version from file
template_version=$(cat TEMPLATE_VERSION)

if [ "$release" = "$template_version" ]; then
    echo "GOOD ! Template version and release version matches ! Release Version=${release}"
    exit 0
else
    echo "ERROR ! Template version and release version differs ! Template Version=${template_version} / Release Version=${release}"
    exit 1
fi
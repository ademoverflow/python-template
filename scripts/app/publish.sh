#!/usr/bin/env bash

PACKAGE_NAME=dummy-app
ECR_REPOSITORY=822030640566.dkr.ecr.eu-west-1.amazonaws.com
IMAGE_ECR_ENDPOINT=${ECR_REPOSITORY}/${PACKAGE_NAME}

# Retrieve named paramater
tag=${tag:-latest}
while [ $# -gt 0 ]; do
   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
   fi
  shift
done

# Configure IMAGE_TAG according to --tag parameter
if [[ "$tag" =~ ^(latest|git)$ ]]; then
    echo "Publishing images with '${tag}' configuration."
    if [ "$tag" == "latest" ]; then
        IMAGE_TAG=latest
    else
        IMAGE_TAG=$(git describe --tags --abbrev=0)
    fi
else
    echo "ERROR: ${tag} is not supported. (latest|git) only."
    exit 1
fi

# Login to ECR
aws ecr get-login-password | docker login --username AWS --password-stdin ${ECR_REPOSITORY}

# Create repository if not exist
aws ecr describe-repositories --repository-names ${PACKAGE_NAME} || aws ecr create-repository --repository-name ${PACKAGE_NAME}

# Tag production and lambda images
docker tag ${PACKAGE_NAME}:production ${IMAGE_ECR_ENDPOINT}:${IMAGE_TAG}
docker tag ${PACKAGE_NAME}:lambda ${IMAGE_ECR_ENDPOINT}:${IMAGE_TAG}-lambda

# Push both images to ECR
docker push ${IMAGE_ECR_ENDPOINT}:${IMAGE_TAG}
docker push ${IMAGE_ECR_ENDPOINT}:${IMAGE_TAG}-lambda
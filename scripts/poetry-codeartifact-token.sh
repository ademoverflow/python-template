#!/usr/bin/env bash

DOMAIN=antipodestudios
REPOSITORY=antipodestudios
CODEARTIFACT_USER=aws
CODEARTIFACT_TOKEN=$(aws codeartifact get-authorization-token --domain ${DOMAIN} --query authorizationToken --output text)


poetry config http-basic.${DOMAIN} ${CODEARTIFACT_USER} ${CODEARTIFACT_TOKEN}
#!/usr/bin/env bash
set -e

args=$(./scripts/codeartifact/args.sh "$@")
IFS=',' read -r -a args <<< "$args"
domain="${args[0]}";repository="${args[1]}"

info=$(bash scripts/codeartifact/get-info.sh --domain ${domain} --repository ${repository})

IFS=',' read -r -a info <<< "$info"
repository_url="${info[0]}";user="${info[1]}";token="${info[2]}"

poetry config http-basic.${domain} ${user} ${token}
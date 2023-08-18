#!/usr/bin/env bash
set -e

args=$(./scripts/codeartifactory-args.sh "$@")
IFS=',' read -r -a args <<< "$args"
domain="${args[0]}";repository="${args[1]}"

info=$(bash scripts/get-codeartifact-info.sh --domain ${domain} --repository ${repository})

IFS=',' read -r -a info <<< "$info"
repository_url="${info[0]}";user="${info[1]}";token="${info[2]}"

poetry config http-basic.${domain} ${user} ${token}
#!/usr/bin/env bash

set -e

domain=${domain:-ademoverflow}
repository=${repository:-ademoverflow}

while [ $# -gt 0 ]; do
   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
   fi
  shift
done

echo "${domain},${repository}"
#!/usr/bin/env bash

set -e

poetry run poe tests
poetry run poe coverage
poetry run poe lint
poetry run poe format
poetry run poe sort-check
poetry run poe type-check

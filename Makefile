.SILENT:

PACKAGE_NAME := python-template

COMPOSE := docker compose
ifeq (${INSIDE_CONTAINER}, 1)
	INSIDE_DOCKER_CONTAINER = true
	RUN :=
else
	INSIDE_DOCKER_CONTAINER = false
	RUN := $(COMPOSE) run --rm $(PACKAGE_NAME)
endif

POETRY := poetry --quiet
BLACK := ${POETRY} run black --check
ISORT := ${POETRY} run isort --check
LINT := ${POETRY} run pylint
TYPE_CHECK := ${POETRY} run mypy
UNIT_TESTS := ${POETRY} run coverage run -m pytest && ${POETRY} run coverage report -m

default: help;

help: ## Display commands help
	@grep -E '^[a-zA-Z][a-zA-Z_-]+:.*?## .*$$' Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.PHONY: help

setup: ## Nothing for now
.PHONY: setup

ifeq ($(INSIDE_DOCKER_CONTAINER), false)
generate_env:
	echo "USER_UID=$$(id -u)" > .env
	echo "USER_GID=$$(id -g)" >> .env
	echo "TZ=$$(timedatectl show -p Timezone | cut -d= -f2)" >> .env

build: generate_env ## Build your container (not available when inside the container)
	${COMPOSE} build ${PACKAGE_NAME}
.PHONY: build

dev: generate_env ## Develop your python_template within the container (not available when inside the container)
	${COMPOSE} down
	${COMPOSE} run --rm -it ${PACKAGE_NAME} bash
.PHONY: dev
endif

check_format: ## Checks for good formatting (implemented with black and isort)
	echo "Checking format for python_template and tests ..."
	@make _check_format_code
	@make _check_format_tests
.PHONY: check_format

_check_format_code: ## Checks for good formatting for python_template (with black and isort)
	echo "Format check for python_template  ..."
	$(RUN) ${BLACK} src/python_template
	$(RUN) ${ISORT} src/python_template
.PHONY: _check_format_code

_check_format_tests: ## Checks for good formatting for tests (with black and isort)
	echo "Format check for tests  ..."
	$(RUN) ${BLACK} tests
	$(RUN) ${ISORT} tests
.PHONY: _check_format_tests

check_linting: ## Checks for python code linting (implemented with pylint and mypy)
	echo "Checking linting and types for python_template and tests ..."
	@make _check_linting_code
	@make _check_linting_tests
.PHONY: check_linting

_check_linting_code: ## Checks for good linting for python_template (with pylint and mypy)
	echo "Checking linting and types for python_template ..."
	$(RUN) ${LINT} src/python_template
	$(RUN) ${TYPE_CHECK} src/python_template
.PHONY: _check_linting_code

_check_linting_tests: ## Checks for good linting for tests (with pylint and mypy)
	echo "Checking linting and types for python_template ..."
	$(RUN) ${LINT} tests
	$(RUN) ${TYPE_CHECK} tests
.PHONY: _check_format_tests

docs: ## Generate docs in html format (with sphinx)
	echo "Generating docs ..."
	rm -f docs/source/python_template*
	sphinx-apidoc --force --no-headings --separate --maxdepth 1 --output-dir docs/source/ src/python_template
	cd docs && make clean && make html && cd ..
.PHONY: docs

unit_test: ## Run tests (with pytest)
	echo "Running tests with coverage report ..."
	$(RUN) bash -c "${UNIT_TESTS}"
.PHONY: unit_test

integ_test: ## Nothing for now
.PHONY: integ_test

nightly_test: ## Nothing for now
.PHONY: nightly_test

post_test: ## Nothing for now
.PHONY: post_test

post_master: ## Nothing for now
.PHONY: post_master

clean: ## Clean all generated files
	rm -rf .mypy_cache
	rm -rf .pytest_cache
	rm -f .coverage
.PHONY: clean
.SILENT:

PACKAGE_NAME := python-template

COMPOSE := docker-compose
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

############################################
# -------- Outside container rules ------- #
############################################

ifeq ($(INSIDE_DOCKER_CONTAINER), false)
generate_env: ## Generate .env file for docker image (not available when inside the container)
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

############################################
# -------------- Formatting -------------- #
############################################

check_format: ## Checks format for all codebase.
	@make check_format_code
	@make check_format_tests
.PHONY: check_format

check_format_code: ## Checks format for python_template (with black and isort)
	echo "Format check for python_template  ..."
	$(RUN) ${BLACK} src/python_template
	$(RUN) ${ISORT} src/python_template
.PHONY: check_format_code

check_format_tests: ## Checks format for tests (with black and isort)
	echo "Format check for tests  ..."
	$(RUN) ${BLACK} tests
	$(RUN) ${ISORT} tests
.PHONY: check_format_tests

############################################
# --------------- Linting ---------------- #
############################################

check_linting: ## Checks linting for all codebase.
	@make check_linting_code
	@make check_linting_tests
.PHONY: check_linting

check_linting_code: ## Checks linting for python_template (with pylint)
	echo "Checking linting for python_template ..."
	$(RUN) ${LINT} src/python_template
.PHONY: check_linting_code

check_linting_tests: ## Checks linting for tests (with pylint)
	echo "Checking linting for tests ..."
	$(RUN) ${LINT} tests
.PHONY: check_linting_tests

############################################
# ----------- Types Checking ------------- #
############################################

check_typing: ## Checks typing for all codebase.
	@make check_typing_code
	@make check_typing_tests
.PHONY: check_typing

check_typing_code: ## Checks for types for python_template (with mypy)
	echo "Checking types for python_template ..."
	$(RUN) ${TYPE_CHECK} src/python_template
.PHONY: check_typing_code

check_typing_tests: ## Checks for types for tests (with mypy)
	echo "Checking types for tests ..."
	$(RUN) ${TYPE_CHECK} tests
.PHONY: check_typing_tests

############################################
# -------------- Testing ----------------- #
############################################

unit_tests: ## Run tests (with pytest)
	echo "Running unit tests with coverage report ..."
	$(RUN) bash -c "${UNIT_TESTS}"
.PHONY: unit_tests

integration_tests: ## Run integration tests
	echo "Running integration tests ..."
.PHONY: integration_tests

############################################
# -------------- Global ------------------ #
############################################

code_quality: ## Runs code quality checkers
	@make check_format
	@make check_linting
	@make check_typing
.PHONY: code_quality

docs: ## Generate docs in html format (with sphinx)
	echo "Generating docs ..."
	rm -f docs/source/python_template*
	sphinx-apidoc --force --no-headings --separate --maxdepth 1 --output-dir docs/source/ src/python_template
	cd docs && make clean && make html && cd ..
.PHONY: docs

next_release: ## Generate next release and publish it to GitHub Releases
	VERSION=$(semantic-release print-version)
	echo "Publishing next release ${VERSION} ..."
	$(RUN) semantic-release publish
.PHONY: next_release

clean: ## Clean all generated files
	rm -rf .mypy_cache
	rm -rf .pytest_cache
	rm -f .coverage
.PHONY: clean
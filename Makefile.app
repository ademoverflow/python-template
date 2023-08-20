.SILENT:

PACKAGE_NAME := python-template

POETRY := poetry --quiet
COMPOSE := docker-compose
ifeq (${INSIDE_CONTAINER}, 1)
	INSIDE_DOCKER_CONTAINER = true
	RUN :=
else
	INSIDE_DOCKER_CONTAINER = false
	RUN := $(COMPOSE) -f docker-compose.dev.yml run --rm $(PACKAGE_NAME)
endif

############################################
# -------- Outside container rules ------- #
############################################

ifeq ($(INSIDE_DOCKER_CONTAINER), false)

generate-env: ## Generate .env file for docker image.
	echo "USER_UID=$$(id -u)" > .env
	echo "USER_GID=$$(id -g)" >> .env
.PHONY: generate-env

build-development: generate-env ## Build development docker image.
	${COMPOSE} -f docker-compose.dev.yml build ${PACKAGE_NAME}
.PHONY: build-development

build-production: generate-env ## Build production docker image.
	${COMPOSE} -f docker-compose.yml build ${PACKAGE_NAME}
.PHONY: build-production

build-lambda: generate-env ## Build lambda docker image.
	${COMPOSE} -f docker-compose.lambda.yml build ${PACKAGE_NAME}
.PHONY: build-lambda

next-version: ## Compute next version and update codebase.
	${COMPOSE} -f docker-compose.dev.yml run -e GH_TOKEN=${GH_TOKEN} --rm ${PACKAGE_NAME} bash -c "scripts/next-version.sh"
.PHONY: next-version

publish-latest: ## Publish latest application docker image.
	${COMPOSE} run --rm ${PACKAGE_NAME} bash -c "scripts/publish-latest.sh"
.PHONY: publish-latest

publish-versioned: ## Publish versioned application docker image.
	${COMPOSE} run --rm ${PACKAGE_NAME} bash -c "scripts/publish-versioned.sh"
.PHONY: publish-versioned

endif

############################################
# ------------- General rules ------------ #
############################################

code-quality: ## Runs code quality checkers
	echo "Running code quality checkers ..."
	$(RUN) $(POETRY) run poe code-quality
.PHONY: code-quality

unit-tests: ## Run tests (with pytest)
	echo "Running unit tests ..."
	$(RUN) $(POETRY) run poe tests
.PHONY: unit-tests

integration-tests: ## Run integration tests
	echo "Running integration tests ..."
	$(RUN) $(POETRY) run poe integration-tests
.PHONY: integration-tests

documentation: ## Generate docs in html format (with sphinx)
	echo "Generating docs ..."
	rm -f docs/source/python_template*
	sphinx-apidoc --force --no-headings --separate --maxdepth 1 --output-dir docs/source/ src/python_template
	cd docs && make clean && make html && cd ..
.PHONY: documentation

clean: ## Clean all generated files
	rm -rf .mypy_cache
	rm -rf .pytest_cache
	rm -f .coverage
	find . | grep -E "(__pycache__|\.pyc|\.pyo$$)" | xargs rm -rf
	rm -f .env
# Clean .venv if outside the container
ifeq ($(INSIDE_DOCKER_CONTAINER), false)
	rm -rf .venv
endif
	
.PHONY: clean
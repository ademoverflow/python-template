.SILENT:

PACKAGE_NAME := python-template

POETRY := poetry --quiet
COMPOSE := docker-compose -f docker-compose.dev.yml
ifeq (${INSIDE_CONTAINER}, 1)
	INSIDE_DOCKER_CONTAINER = true
	RUN :=
else
	INSIDE_DOCKER_CONTAINER = false
	RUN := $(COMPOSE) run --rm $(PACKAGE_NAME)
endif

############################################
# -------- Outside container rules ------- #
############################################

ifeq ($(INSIDE_DOCKER_CONTAINER), false)
generate-env: ## Generate .env file for docker image.
	echo "USER_UID=$$(id -u)" > .env
	echo "USER_GID=$$(id -g)" >> .env
.PHONY: generate-env

build: generate-env ## Build development docker image.
	${COMPOSE} build ${PACKAGE_NAME}

next-release: ## Generate next release and publish it to GitHub Releases.
	${COMPOSE} run \
		-e GH_TOKEN=${GH_TOKEN} \
		-e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
		-e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
		-e AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} \
		--rm ${PACKAGE_NAME} bash -c "scripts/next-release.sh"
.PHONY: next-release

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
.PHONY: clean
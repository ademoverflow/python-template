# python-template

## Service description

description-here

## Repository information

This repository aims to facilitate the development of a python service / library, packaged with the help of `poetry` and dockerized properly.

It contains the adequate tooling for:

- Unit testing and code coverage (with `pytest` and `coverage` dependencies)
- Code formatting with `black` + `isort` and linting with `pylint`
- Strong type checking with `mypy`

All the configuration for these tools are located directly in `pyproject.toml`, you don't need dot files for this (awesome, isn't it ?)

## Project organization

Let's see what's inside each folder:

- `.devcontainer`: folder used by vscode to configure `Dev Containers` extension
- `.vscode`: folder used by vscode to configure your project's basic configuration.
- `src/python_template`: where the magic happens
- `tests`: where the magic is tested (or at least, it's supposed to be tested.)

And files:

- `.dockerignore`: list of files and folders to ignore when building Docker images.
- `.gitignore`: list of files and folders to ignore in git.
- `docker-compose.yml`: Defines python_template production service.
- `docker-compose.dev.yml`: Defines python_template development service. Used for local development, and CI (to run code code quality checks).
- `docker-compose.lambda.yml`: Defines python_template lambda service. Used for lambda deployment (if you use it).
- `Dockerfile`: your service / library docker image, with multistage (development, production and lambda).
- `Makefile`: `make` rules, mostly used for CI BUT usable also inside the dev container.
- `pyproject.toml`, `poetry.toml`, `poetry.lock`: `poetry` files.
- `README.md`: project documentation.
- `.TEMPLATE_VERSION`: file that contains the template version used for this project (generated by repo-init.sh)

## Containerization

The package is dockerized to ease its development and production deployment.

Inside the Dockerfile you'll find three important stages `development`, `production` and `lambda`.

- `development`: Contains all the tools for development.
- `production`: Minimal image that contains production code only.
- `lambda`: Minimal image that contains production code only, and is ready to be deployed on AWS Lambda.

## What you need on your machine

### For Visual Studio Code Users

This template uses a killer feature available on vscode: `Dev Containers`. You need to install the extension to make it available.

It basically allows you to develop within your container, with full IDE features support (integrated terminal, autocompletion, warnings and errors, etc.)

You do not need to install poetry, neither the right python version or create a virtualenv.

You only need `docker` and its `compose` plugin installed. Nothing else.

These versions of docker and docker-compose are known to work:

- docker: 24.0.2
- docker-compose: 2.20.2

**How to launch your project with Dev Containers**

When you open a project based on this repository, on vscode you just have to `Ctrl+Shift+P` to open vscode command helper and type `Dev Containers: Open Folder in Container`.

Vscode will restart, build your container, install on it vscode-server and some plugins, and .. Tada ! You are ready to code !

**Note**: sometimes plugins do not start properly (example: isort fails to start because it needs python plugin to be ready, it's a race start condition issue). In this case, you just need to reload your vscode:

`Ctrl+Shift+P` and type `Developer: Reload Window`.

That's it ! You are ready to go.

**How the hell this works ?**

Let's explain a bit how the extension works.

When you open a folder in a container, vscode will look for a `.devcontainer` folder at the root of your project.

If it finds it, it will use it to configure the Dev Container.

In the `.devcontainer` folder, you'll find a `devcontainer.json` file, which contains the configuration for the container.

In this file, you'll find a `dockerComposeFile` key, which defines the compose file to use to build the container.

In our case, it is `docker-compose.dev.yml`.

This file defines a service named `python_template`, which is the name of our project.

This service is based on the `Dockerfile` file, and is configured to use the `development` stage.

This stage is defined in the `Dockerfile` file, and contains all the tools needed for development.

So, when you open a folder in a container, vscode will build the container based on the `docker-compose.dev.yml` file, which will build the container based on the `Dockerfile` file, and will use the `development` stage.

Extensions defined in the `devcontainer.json` file are installed in the container, and you are ready to go !

## Makefile

A Makefile is provided to let you run basic commands easily.

It is developed for the CI/CD mostly, but it is also usable inside the container (at least some code related rules).

Indeed, some rules cannot be launched inside the container, like `build` (which builds the Docker image), so we disable the rule inside the Makefile.

Go check the Makefile to see what you can do with it, documentation is provided inside.

## GitHub Actions

For workflows to work properly, you need to give some access to Actions:

- In Settings / Actions / General -> Workflows permission, choose "Read and write permissions".

## Template usage

This repository is a template.

To use this template, just create your github repository and select this template.

Once you've created it, launch the script [repo-init.sh](./scripts/repo-init.sh) to clean the repository.

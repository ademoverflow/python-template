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
- `python_template`: where the magic happens
- `tests`: where the magic is tested (or at least, it's supposed to be tested.)

And files:

- `.dockerignore`: list of files and folders to ignore when building Docker images.
- `.gitignore`: list of files and folders to ignore in git.
- `docker-compose.yml`: mostly used for dev purpose, defines a simple service with your python_template.
- `Dockerfile`: your service / library docker image, with multistage (development and production).
- `env.example`: an example env file for your project.
- `Makefile`: `make` rules, mostly used for CI BUT usable also inside the dev container.
- `pyproject.toml`, `poetry.toml`, `poetry.lock`: `poetry` files.
- `README.md`: project documentation.
- `TEMPLATE_VERSION`: file that contains the template version used for this project.

## Containerization

The package is dockerized to ease its development and production deployment.

Inside the Dockerfile you'll find two important stages `development` and `production`:

- `production`: minimal image that contains production code only.
- `development`: contains all the tools for development.


## What you need on your machine

### For Visual Studio Code Users

This template uses a killer feature available on vscode: `Dev Containers`. You need to install the extension to make it available.

It basically allows you to develop within your container, with full IDE features support (integrated terminal, autocompletion, warnings and errors, etc.)

You do not need to install poetry, neither the right python version or create a virtualenv.

You only need `docker` and its `compose` plugin installed. Nothing else.

**How to launch your project with Dev Containers**

When you open a project based on this repository, on vscode you just have to `Ctrl+Shift+P` to open vscode command helper and type `Dev Containers: Open Folder in Container`.

Vscode will restart, build your container, install on it vscode-server and some plugins, and .. Tada ! You are ready to code !

__Note__: sometimes plugins does not start properly (example: isort fails to start because it needs python plugin to be ready, it's a race start condition issue). In this case, you just need to reload your vscode:

`Ctrl+Shift+P` and type `Developer: Reload Window`.

That's it ! You are ready to go.

**How the hell this works ?**

Let's explain a bit how all of this work.

`Dev Containers` allows you to use a container for local development.

We configure the vscode extension with `.devcontainer` folder to use the `development` stage of Dockerfile, through the definition of the service within the `docker-compose.yml` file.

Docker image build, args, env variables and volume mounts are all defined in the compose file.

Vscode extensions that must be installed in the container to give you the best development experience are defined in `.devcontainer` folder.

### Other IDEs

If you are using an IDE that does not support developing inside a container, you should be able to develop inside the container by just using `make dev`.

You won't have autocompletion :(

__Note__: if you manage to make it fully working within your IDE, feel free to add the adequate config and documentation here ! (And also in the template).


## Makefile

A Makefile is provided to let you run basic commands easily.

It is developed for the CI/CD mostly, but it is also usable inside the container (at least some code related rules).

Indeed, some rules cannot be launched inside the container, like `build` (which builds the Docker image), so we disable the rule inside the Makefile.

## Template usage

This repository is a template.

To use this template:

- Clone it and launch `repo-init.sh` script:

```bash
git clone "ssh://<username>@gerrit.ademus.lan:29418/ademus/python-template" <my_awesome_app> && cd <my_awesome_app> && ./scripts/repo-init.sh
```

Replace `<username>` by your gerrit name and <my_awesome_app> with the name of your brand new service / library.

This script will ask you some project configuration, and that´s it !
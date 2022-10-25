# my-awesome-service

## Service description

description-here

## Repository information

This repository aims to facilitate the development of a python microservice, packaged with the help of `poetry` and dockerized properly.

It contains the adequate tooling for:
- Unit testing and code coverage (with `pytest` and `coverage` dependencies)
- Code formatting with `black` and linting with `pylint`
- Strong type checking with `pyright`

All the configuration for these tools are located directly in [pyproject.toml](./pyproject.toml), you don't need dot files for this.

## What you need on your machine

### Python
As the template is configured for `python3.8`, you need to install it. 

__Note for Mac users__: 

- You can install and use `pyenv` to install several versions of Python.
- You just need to specify which version of python you want to run within your current shell with `pyenv shell 3.8.13` for example (you need to install it first).

### Poetry

Poetry is the most powerful python package manager of the ecosystem.

You can install it as a python package globally for your version of python, with pip: `python -m pip install poetry`

### Docker

You obviously need to run `Docker` on your machine to be able to build and run containers.

__Note__: if you want to use private repositories in your dependencies, you need to forward your ssh keys to the docker build context:

- `ssh-add -K` to "copy" your ssh keys on the docker environment (run it once)
- Run each build with `DOCKER_BUILDKIT=1` shell variable.

__Example__:

Let's say I want to build the `development` stage of my python app, and I need to forward my ssh keys to the build context. I just need to run this:

```bash
DOCKER_BUILDKIT=1 docker build --target=development  --ssh default -t my-awesome-app .
```

On the Dockerfile, the layers that need ssh keys MUST begin with `RUN --mount=type=ssh`.

For more details on this feature, go check Docker documentation.


## Development

Just code your app like you normally would.

## How to use this template

- Clone this repository with the name of your service: `git clone <URL_OF_TEMPLATE_REPO> my-awesome-app
- Delete the .git folder and launch `git init` to start a new git repository on the folder.
- Search and replace `my-awesome-service` by your service name.
- Add the adequate service description on the README file, in `Service description`.
- Enjoy !
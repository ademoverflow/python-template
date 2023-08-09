# -----------------------------------------#
# -------------- Base target ------------- #
# -----------------------------------------#
# Content:
# - Create a non-root user and group with its home directory
# - Install and configure ssh (to be able to fetch private repositories)

FROM --platform=linux/amd64 python:3.10-slim AS base

# -- Retrieve UID and GID from build args
ARG USER_UID
ARG USER_GID

# -- Python related environment variables
ENV INSIDE_CONTAINER=1
ENV PYTHONUNBUFFERED=true

# -- Create a non-root user
ENV USERNAME=antipodestudios
ENV GROUP_NAME=antipodestudios

# -- Define home and code directory
ENV HOME_DIR=/home/${USERNAME}
ENV CODE_DIR=${HOME_DIR}/code
WORKDIR ${CODE_DIR}

# -- Create USER and GROUP
RUN groupadd -g ${USER_GID} ${GROUP_NAME}
RUN adduser -uid ${USER_UID} -gid ${USER_GID} ${USERNAME} --home ${HOME_DIR}
RUN chown -R ${USER_UID}:${USER_GID} ${HOME_DIR}

# -- Install and configure ssh
RUN apt-get update && apt-get install -y ssh
USER ${USERNAME}
RUN mkdir -p -m 0700 ${HOME_DIR}/.ssh
RUN ssh-keyscan github.com >> ${HOME_DIR}/.ssh/known_hosts

# -----------------------------------------#
# ------------ Builder target ------------ #
# -----------------------------------------#

FROM base AS builder

# -- Install build dependencies
USER root
RUN apt-get update && apt-get install -y curl

# -- Install poetry
USER ${USERNAME}
ENV POETRY_VERSION=1.5.1 \
    POETRY_NO_INTERACTION=1 \
    POETRY_HOME="${HOME_DIR}/.poetry"
ENV PATH="$POETRY_HOME/bin:$PATH"
RUN curl -sSL https://install.python-poetry.org | python3 -

# -- Generate requirements.txt file from pyproject.toml (for production and lambda targets)
COPY --chown=${USERNAME}:${GROUP_NAME} pyproject.toml ${CODE_DIR}/pyproject.toml
COPY --chown=${USERNAME}:${GROUP_NAME} poetry.lock ${CODE_DIR}/poetry.lock
COPY --chown=${USERNAME}:${GROUP_NAME} poetry.toml ${CODE_DIR}/poetry.toml

RUN --mount=type=ssh,uid=${USER_UID},gid=${USER_GID} poetry export --only main --no-interaction --without-hashes -f requirements.txt -o requirements.txt

# --------------------------------- #
# ------- Development target ------ #
# --------------------------------- #

FROM builder AS development

# -- Let the user use sudo without password prompt
USER root
RUN apt-get update && apt-get install -y sudo
RUN adduser ${USERNAME} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# -- Install tools
USER ${USERNAME}
RUN sudo apt-get install -y make neovim vim nano git sudo bash-completion

# -- Activate bash-completion
RUN cat /etc/profile.d/bash_completion.sh >> ${HOME_DIR}/.bashrc

# -- Install all dependencies BUT code source
RUN --mount=type=ssh,uid=${USER_UID},gid=${USER_GID} poetry install --no-root

# -- Copy source code
COPY --chown=${USERNAME}:${GROUP_NAME} . ${CODE_DIR}/

# -- Install all dependencies including code source
RUN --mount=type=ssh,uid=${USER_UID},gid=${USER_GID} poetry install

# -- Enable poetry completion
USER root
RUN poetry completions bash > /usr/share/bash-completion/completions/poetry

# -- Main command
USER ${USERNAME}
CMD poetry run python -m python_template 2>&1 | tee ${CODE_DIR}/server.log

# --------------------------------- #
# ------- Production target ------- #
# --------------------------------- #

FROM base AS production

# -- Install dependencies
RUN pip install --upgrade pip
COPY --from=builder --chown={USER_UID}:{USER_GID} ${CODE_DIR}/requirements.txt ${CODE_DIR}/requirements.txt
RUN --mount=type=ssh,uid=${USER_UID},gid=${USER_GID} pip install -r ${CODE_DIR}/requirements.txt

COPY --chown={USER_UID}:{USER_GID} src/python_template ${CODE_DIR}/python_template

# -- Main command
WORKDIR ${CODE_DIR}
USER ${USERNAME}
CMD ["python", "-m", "python_template"]

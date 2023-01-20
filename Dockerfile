# ---------- Base target ---------- #
# --------------------------------- #
# Content:
#  - Define which python version will be used.
#  - Defines some python related environment variables
#  - Defines which workdir we'll be using.

FROM --platform=linux/amd64 python:3.10-slim AS base

ENV PYTHONUNBUFFERED=true
ENV CODE_DIR=/home/ademus/code

ENV USERNAME=ademus
ENV GROUP_NAME=ademus

ARG USER_UID=$USER_UID
ARG USER_GID=$USER_GID

RUN groupadd -g ${USER_GID} ${GROUP_NAME}
RUN adduser -uid ${USER_UID} -gid ${USER_GID} ${USERNAME}

WORKDIR ${CODE_DIR}

# --------------------------------- #
# -------- Builder target --------- #
# --------------------------------- #
# Content:
#  - Installs poetry with a specific version
#  - Copy poetry config files.
#  - Create a requirements.txt file (that will be used for production ONLY)
FROM base AS builder

ENV POETRY_HOME="/opt/poetry" \
    POETRY_NO_INTERACTION=1

ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

ENV POETRY_VERSION=1.3.2

RUN apt-get update && \
    apt-get install -y curl git

RUN curl -sSL https://install.python-poetry.org | python3 -

COPY pyproject.toml ${CODE_DIR}/pyproject.toml
COPY poetry.toml ${CODE_DIR}/poetry.toml
COPY poetry.lock ${CODE_DIR}/code/poetry.lock

# Note: this file generation is ONLY used in production target,
# as production is as light as possible (only python and pip, no poetry).
RUN poetry export --output ${CODE_DIR}/requirements.txt 

# --------------------------------- #
# ------ Development target ------- #
# --------------------------------- #
# Content:
#  - Installs all dependencies using poetry
#  - Copies entire code base (python_template, tests and scripts)

FROM builder as development

ENV INSIDE_CONTAINER=1

RUN apt-get install -y make vim nano sudo bash-completion
RUN poetry install --no-root

COPY src ${CODE_DIR}/src
COPY tests ${CODE_DIR}/tests
COPY scripts ${CODE_DIR}/scripts
COPY stubs ${CODE_DIR}/stubs
COPY README.md ${CODE_DIR}/README.md

# This second poetry install commands only installs python_template as a package
RUN poetry install 

# A small hack to let all the users install python packages.
RUN chmod -R 777 /usr/local/

# Let the user use sudo without password prompt
RUN adduser ${USERNAME} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ${USERNAME}

# --------------------------------- #
# ------- Production target ------- #
# --------------------------------- #
# Content:
#  - Installs only production dependencies with requirements.txt
#  - Copies only production code base

FROM base AS production

RUN pip install --upgrade pip
COPY --from=builder ${CODE_DIR}/requirements.txt ${CODE_DIR}/requirements.txt
RUN pip install -r ${CODE_DIR}/requirements.txt

COPY src ${CODE_DIR}/src

USER ${USERNAME}

CMD ["python", "-m", "python_template"]

# ---------------------------------------- #
# ------- Common build arguments --------- #
# ---------------------------------------- #

# -- Python version
ARG PYTHON_VERSION=3.10

# -- Code Artifact parameters
ARG CODEARTIFACT_DOMAIN=antipodestudios
ARG CODEARTIFACT_REPOSITORY=antipodestudios

# ---------------------------------------- #
# -------------- Base target ------------- #
# ---------------------------------------- #
# Content:
# - Create a non-root user and group with its home directory

FROM python:${PYTHON_VERSION}-slim AS base

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

# --------------------------------- #
# ------- Development target ------ #
# --------------------------------- #
# Content:
# - Install build dependencies
# - Install dev tools
# - Install poetry
# - Copy source code
# - Install all dependencies including code source
# - Enable poetry completion

FROM base AS development

# -- Code Artifact parameters
ARG CODEARTIFACT_DOMAIN
ARG CODEARTIFACT_REPOSITORY

# -- Install build dependencies
RUN apt-get update && apt-get install -y curl

# -- Install poetry
USER ${USERNAME}
ENV POETRY_VERSION=1.5.1 \
    POETRY_NO_INTERACTION=1 \
    POETRY_HOME="${HOME_DIR}/.poetry"
ENV PATH="$POETRY_HOME/bin:$PATH"
RUN curl -sSL https://install.python-poetry.org | python3 -

# -- Let the user use sudo without password prompt
USER root
RUN apt-get update && apt-get install -y sudo
RUN adduser ${USERNAME} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# -- Install tools
USER ${USERNAME}
RUN sudo apt-get install -y make neovim vim nano git sudo bash-completion awscli

# -- Get default bashrc 
RUN cp /etc/skel/.bashrc ~/.bashrc

# -- Copy source code
COPY --chown=${USERNAME}:${GROUP_NAME} . ${CODE_DIR}/

# -- Install all dependencies including code source
RUN --mount=type=secret,id=aws,target=${HOME_DIR}/.aws/credentials,uid=${USER_UID},gid=${USER_GID} bash scripts/codeartifact/configure-poetry.sh \
    --domain ${CODEARTIFACT_DOMAIN} \
    --repository ${CODEARTIFACT_REPOSITORY}
RUN poetry install

# -- Enable poetry completion
USER root
RUN poetry completions bash > /usr/share/bash-completion/completions/poetry

# -- Main command
USER ${USERNAME}
CMD poetry run python -m python_template 2>&1 | tee ${CODE_DIR}/server.log

# --------------------------------- #
# ------- Production target ------- #
# --------------------------------- #
# Content:
# - Install git (to be able to fetch private repositories)
# - Install dependencies
# - Install antipode-logging

FROM base AS production

# -- Code Artifact parameters
ARG CODEARTIFACT_DOMAIN
ARG CODEARTIFACT_REPOSITORY

# -- Install build dependencies
RUN apt-get update && apt-get install -y awscli

# -- Copy source code
COPY --chown={USER_UID}:{USER_GID} src ${CODE_DIR}/src
COPY --chown={USER_UID}:{USER_GID} pyproject.toml ${CODE_DIR}/pyproject.toml
COPY --chown={USER_UID}:{USER_GID} README.md ${CODE_DIR}/README.md

# -- Own code directory
USER root
RUN chown -R ${USER_UID}:${USER_GID} ${CODE_DIR}

# Login to AWS codeartifact to install private packages
USER ${USERNAME}
RUN --mount=type=secret,id=aws,target=${HOME_DIR}/.aws/credentials,uid=${USER_UID},gid=${USER_GID} \
    aws codeartifact login \
        --tool pip \
        --domain ${CODEARTIFACT_DOMAIN} \
        --repository ${CODEARTIFACT_REPOSITORY}
RUN sed -i 's/index-url/extra-index-url/g' ${HOME_DIR}/.config/pip/pip.conf 

# -- Install python dependencies
RUN pip install --upgrade pip
RUN pip install -e ${CODE_DIR}

# -- Uninstall build dependencies
USER root
RUN apt-get remove --purge -y git awscli

USER ${USERNAME}
CMD ["python", "-m", "python_template"]

# --------------------------------- #
# --------- Lambda target --------- #
# --------------------------------- #
# Content:
# - Copy source code
# - Install production dependencies

FROM public.ecr.aws/lambda/python:${PYTHON_VERSION} AS lambda

# -- Code Artifact parameters
ARG CODEARTIFACT_DOMAIN
ARG CODEARTIFACT_REPOSITORY

# -- Copy source code
COPY pyproject.toml pyproject.toml
COPY README.md README.md
COPY src/python_template ${LAMBDA_TASK_ROOT}/src/python_template

# -- Install build dependencies
RUN yum install -y awscli

# Login to AWS codeartifact to install private packages
RUN mkdir -p /root/.aws
RUN --mount=type=secret,id=aws,target=/root/.aws/credentials \
    aws codeartifact login \
        --tool pip \
        --domain ${CODEARTIFACT_DOMAIN} \
        --repository ${CODEARTIFACT_REPOSITORY}
RUN sed -i 's/index-url/extra-index-url/g' ${HOME}/.config/pip/pip.conf 

# -- Install python dependencies
RUN pip install --upgrade pip
RUN pip install -e .

# -- Uninstall build dependencies
RUN yum remove -y awscli

CMD [ "python_template.main.handler" ]
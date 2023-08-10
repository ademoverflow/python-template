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

# -- Let the user use sudo without password prompt
USER root
RUN apt-get update && apt-get install -y sudo
RUN adduser ${USERNAME} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# -- Install tools
USER ${USERNAME}
RUN sudo apt-get install -y make neovim vim nano git sudo bash-completion

# -- Get default bashrc 
RUN cp /etc/skel/.bashrc ~/.bashrc

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
# Content:
# - Install git (to be able to fetch private repositories)
# - Install dependencies
# - Install python-template

FROM base AS production

USER ${USERNAME}

# -- Install git (to be able to fetch private repositories)
USER root
RUN apt-get update && apt-get install -y git

# -- Install dependencies
USER ${USERNAME}
RUN pip install --upgrade pip

# -- Copy source code
COPY --chown={USER_UID}:{USER_GID} src ${CODE_DIR}/src
COPY --chown={USER_UID}:{USER_GID} pyproject.toml ${CODE_DIR}/pyproject.toml
COPY --chown={USER_UID}:{USER_GID} README.md ${CODE_DIR}/README.md

# -- Own code directory
USER root
RUN chown -R ${USER_UID}:${USER_GID} ${CODE_DIR}

# -- Install python-template
USER ${USERNAME}
RUN --mount=type=ssh,uid=${USER_UID},gid=${USER_GID} pip install -e ${CODE_DIR}

CMD ["python", "-m", "python_template"]

# --------------------------------- #
# --------- Lambda target --------- #
# --------------------------------- #
# Content:
# - Install ssh client for git private packages
# - Configure ssh-client
# - Copy source code
# - Install production dependencies

FROM public.ecr.aws/lambda/python:3.10 AS lambda

# -- Install ssh client for git private packages
RUN yum install -y openssh-clients git

# -- Configure ssh-client
RUN mkdir -p -m 0600 ~/.ssh && \
    ssh-keyscan github.com >> ~/.ssh/known_hosts

# -- Copy source code
COPY pyproject.toml pyproject.toml
COPY README.md README.md
COPY src/python_template ${LAMBDA_TASK_ROOT}/src/python_template

# -- Install production dependencies:
RUN pip install --upgrade pip
RUN --mount=type=ssh pip install -e .

# -- Uninstall ssh client and git
RUN yum remove -y openssh-clients && \
    yum remove -y git && \
    yum clean all

CMD [ "python_template.main.handler" ]
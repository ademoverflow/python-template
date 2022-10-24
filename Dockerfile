# syntax=docker/dockerfile:1.0.0-experimental

# ===== BASE 
FROM --platform=linux/amd64 python:3.10-slim AS base

ENV PYTHONUNBUFFERED=true \
    POETRY_HOME="/opt/poetry" \
    POETRY_NO_INTERACTION=1

ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

WORKDIR /code

# ===== BUILDER 
FROM base AS builder

ENV POETRY_VERSION=1.2.2

RUN apt-get update && \
    apt-get install -y ssh curl

RUN curl -sSL https://install.python-poetry.org | python3 -

RUN mkdir -p -m 0700 ~/.ssh && \ 
    ssh-keyscan github.com >> ~/.ssh/known_hosts

COPY pyproject.toml /code/pyproject.toml
COPY poetry.toml /code/poetry.toml
COPY poetry.lock /code/poetry.lock

RUN --mount=type=ssh poetry run poetry install --no-interaction --no-root --only main

# ===== PRODUCTION 
FROM base AS production

# Copy project python dependencies
COPY --from=builder $POETRY_HOME $POETRY_HOME
COPY --from=builder /code /code

COPY app /code/app
RUN poetry install --no-interaction --only main

CMD ["poetry", "run", "python",  "-m", "app"]

# ===== DEVELOPMENT 
FROM production as development

COPY tests /code/tests
COPY scripts /code/scripts
RUN poetry install --no-interaction

CMD ["/code/scripts/code-quality.sh"]
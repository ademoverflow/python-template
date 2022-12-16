# --------------------------------- #
# ---------- Base target ---------- #
# --------------------------------- #
# Content:
#  - Define which python version will be used.
#  - Defines some python related environment variables
#  - Defines which workdir we'll be using.

FROM --platform=linux/amd64 python:3.10-slim AS base

ENV PYTHONUNBUFFERED=true
WORKDIR /code

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

ENV POETRY_VERSION=1.2.2

RUN apt-get update && \
    apt-get install -y curl

RUN curl -sSL https://install.python-poetry.org | python3 -

COPY pyproject.toml /code/pyproject.toml
COPY poetry.toml /code/poetry.toml
COPY poetry.lock /code/poetry.lock

RUN poetry export --output /code/requirements.txt 

# --------------------------------- #
# ------ Development target ------- #
# --------------------------------- #
# Content:
#  - Installs all dependencies using poetry
#  - Copies entire code base (app, tests and scripts)

FROM builder as development

RUN poetry config virtualenvs.create false --local
RUN poetry install --no-root

COPY app /code/app
COPY tests /code/tests
COPY scripts /code/scripts

# This second poetry install commands only installs app as a package
RUN poetry install 

CMD ["/code/scripts/code-quality.sh"]

# --------------------------------- #
# ------- Production target ------- #
# --------------------------------- #
# Content:
#  - Installs only production dependencies with requirements.txt
#  - Copies only production code base

FROM base AS production

RUN pip install --upgrade pip
COPY --from=builder /code/requirements.txt /code/requirements.txt
RUN pip install -r /code/requirements.txt

COPY app /code/app

CMD ["python",  "-m", "app"]

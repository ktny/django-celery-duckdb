FROM python:3.11-slim

RUN apt upgrade -y && apt update -y
# RUN apt install -y gcc procps util-linux sysstat curl
COPY --from=ghcr.io/astral-sh/uv:0.5.24 /uv /uvx /bin/
# RUN curl -LsSf https://astral.sh/uv/install.sh | sh

COPY ./pyproject.toml ./uv.lock ./
RUN uv sync

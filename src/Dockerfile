FROM python:3.11-slim

RUN apt upgrade -y && apt update -y
RUN apt install -y procps util-linux sysstat
COPY --from=ghcr.io/astral-sh/uv:0.5.24 /uv /uvx /bin/

COPY ./pyproject.toml ./uv.lock ./
RUN uv sync

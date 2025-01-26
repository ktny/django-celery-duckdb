#!/bin/bash

GUNICORN_THREADS="${GUNICORN_THREADS:-1}"

uv run gunicorn -k gthread --threads "${GUNICORN_THREADS}" --bind 0.0.0.0:8000 common.wsgi:application

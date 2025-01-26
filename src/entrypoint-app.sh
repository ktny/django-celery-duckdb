#!/bin/bash

CPU_AFFINITY="${CPU_AFFINITY:-0}"
GUNICORN_THREADS="${GUNICORN_THREADS:-1}"

taskset -c "${CPU_AFFINITY}" uv run gunicorn -k gthread --threads "${GUNICORN_THREADS}" --bind 0.0.0.0:8000 common.wsgi:application

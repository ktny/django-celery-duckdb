#!/bin/bash

CELERY_CONCURRENCY="${CELERY_CONCURRENCY:-1}"

uv run celery -A common worker -c "${CELERY_CONCURRENCY}"

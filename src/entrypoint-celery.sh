#!/bin/bash

CPU_AFFINITY="${CPU_AFFINITY:-0}"
CELERY_CONCURRENCY="${CELERY_CONCURRENCY:-1}"

taskset -c "${CPU_AFFINITY}" uv run celery -A common worker -c "${CELERY_CONCURRENCY}"

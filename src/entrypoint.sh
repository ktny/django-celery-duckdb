#!/bin/bash

uv run gunicorn --bind 0.0.0.0:8000 common.wsgi:application

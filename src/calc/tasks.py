import duckdb
from celery import shared_task


@shared_task
def duck(x, y):
    result = duckdb.sql("SELECT 42").fetchall()
    return result

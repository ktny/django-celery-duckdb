import duckdb
from celery import shared_task


@shared_task
def duck(x, y):
    result = duckdb.sql("select count(*) from '/data/sample.csv'").fetchall()
    return result

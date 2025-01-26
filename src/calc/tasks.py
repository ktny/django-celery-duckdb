import os

import duckdb
from celery import shared_task

QUERY_DIR_PATH = "/opt/calc/queries"
DUCKDB_FILE_PATH = "/data/tpc-h/tpc-h.duckdb"


@shared_task
def duck():
    sql = read_sql_file(os.path.join(QUERY_DIR_PATH, "22.sql"))
    with duckdb.connect(DUCKDB_FILE_PATH, read_only=True) as con:
        result = con.sql(sql).fetchall()
        return result


def read_sql_file(file_path):
    with open(file_path, "r", encoding="utf-8") as file:
        sql_string = file.read()
    return sql_string

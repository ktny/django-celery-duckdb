# TPC-HのデータセットをDuckDBファイルに作成する

```sh
duckdb tpc-h.duckdb

# テーブル定義を読み込む
.read ddl.sql

# データを読み込んで1テーブルずつparquetを作成しそのビューとして読み込む
.read import.sql
```

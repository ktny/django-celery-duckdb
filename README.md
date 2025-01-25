# データ準備

TPC-Hでデータを生成した後、duckdbにparquetを参照するビューを生成する

```sh
cd data/tpc-h
duckdb tpc-h.duckdb

# テーブル定義を読み込む
.read ddl.sql

# データを読み込んで1テーブルずつparquetを作成しそのビューとして読み込む
.read import.sql
```

# スループット計測

```sh
# サーバを立ち上げる
docker compose up -d

# 5並列で10秒間のスループットを計測する
ab  -c 5 -t 10 http://127.0.0.1:8000/
```

# flowerでcelery, rabbit-mqをモニタリングする

```sh
uv run celery -A common flower -basic_auth=guest:guest --broker_api="http://guest:guest@broker:15672/api/vhost"

open http://localhost:5555/
```

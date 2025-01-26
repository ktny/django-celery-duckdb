# コンテナ立ち上げ

```sh
docker compose up -d
```

# データ準備

TPC-Hでデータを生成した後、duckdbにparquetを参照するビューを生成する。
なお、DuckDBのTPC-H Extensionでより簡単にベンチマーク用データ生成、ベンチマーク実行もできる。
[TPC-H Extension](https://duckdb.org/docs/extensions/tpch.html)

```sh
docker compose exec celery uv run /data/tpc-h/prepare.py
```

# スループット計測

```sh
# 5並列で10秒間のスループットを計測する
ab  -c 5 -t 10 http://127.0.0.1:8000/
```

# flowerでcelery, rabbit-mqをモニタリングする

```sh
uv run celery -A common flower -basic_auth=guest:guest --broker_api="http://guest:guest@broker:15672/api/vhost"

open http://localhost:5555/
```

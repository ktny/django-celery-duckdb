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

# パフォーマンス計測

```sh
# 10並列で合計100回リクエストを計測する
# -lでレスポンスのバイト数の違いをFailedとして処理しなくする
ab -c 10 -n 100 -l http://localhost:8000/?q=1
```

# モニタリング

flowerでcelery, rabbit-mqをモニタリングする

```sh
uv run celery -A common flower -basic_auth=guest:guest --broker_api="http://guest:guest@broker:15672/api/vhost"

open http://localhost:5555/
```

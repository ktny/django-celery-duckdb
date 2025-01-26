# これはなに

djangoをベースにgunicorn - celery - duckdb構成でパフォーマンスを計測するためのリポジトリ。
下記を行うことができる。

- TPC-Hのデータに対するクエリをhttpリクエストで実行（TPC-Hのtblデータは[/data/tpc-h/tbl]に格納が必要）
- celeryをノード用キューで複数立ち上げネットワーク的に疎通しているrabbit-mqと接続し処理ワーカーを増やす
- 環境変数より使用CPUを指定し単一ノードでもCPUのスケーリングを模した動きでの計測を行う
- 計測結果をJupyterNotebookで可視化

# 使い方

## コンテナ立ち上げ

```sh
# メインとノードを繋ぐためのnetworkを作成
docker network create external

# メインコンテナの立ち上げ。app(gunicorn), celery(main), broker(rabbit-mq)が立ち上がる
docker compose up -d

# celeryノードコンテナの立ち上げ。brokerコンテナと連携しタスクを処理する
docker compose -f compose.node.yml up
```

## データ準備

### TPC-Hでデータを生成

TPC-Hでtblデータを生成し、[/data/tpc-h/tbl]する。
詳細は下記URLを参照。
https://www.tpc.org/tpch/
https://github.com/ktny/tpc-h
https://duckdb.org/docs/extensions/tpch.html

### DuckDB用のparquet, viewを生成

```sh
docker compose exec celery uv run /data/tpc-h/prepare.py
```

## パフォーマンス計測

```sh
# 正常稼働しているか確認
curl http://localhost:8000/?q=1

# 10並列で合計100回リクエストを計測する
# -lでレスポンスのバイト数の違いをFailedとして処理しなくする
ab -c 10 -n 100 -l http://localhost:8000/?q=1
```

[scripts]内のJupyterNotebookにより可視化ができるようになっている。
詳細は各スクリプトを参照。

## モニタリング

flowerでcelery, rabbit-mqをモニタリングする。
下記コマンド実行後、http://localhost:5555/ で確認できる。

```sh
docker compose exec celery uv run celery -A common flower -basic_auth=guest:guest --broker_api="http://guest:guest@broker:15672/api/vhost"
```


# 計測結果例

## 環境

8CPUで以下の環境変数で計測

```sh
MAIN_CPU_AFFINITY=0-3 or 0-1
NODE_CPU_AFFINITY=4-7
GUNICORN_THREADS=8
CELERY_CONCURRENCY=4
```

ベンチマークコマンド
```sh
ab -c 20 -n 100 -l http://localhost:8000/?q=1
```

## 比較結果

### ノードを立ち上げず、メインのceleryは2コアのみ使用した場合

```
Concurrency Level:      20
Time taken for tests:   59.095 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      96107 bytes
HTML transferred:       68807 bytes
Requests per second:    1.69 [#/sec] (mean)
Time per request:       11818.943 [ms] (mean)
Time per request:       590.947 [ms] (mean, across all concurrent requests)
Transfer rate:          1.59 [Kbytes/sec] received
```

### ノードを立ち上げず、メインのceleryは4コアのみ使用した場合

```txt
Concurrency Level:      20
Time taken for tests:   42.011 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      96149 bytes
HTML transferred:       68849 bytes
Requests per second:    2.38 [#/sec] (mean)
Time per request:       8402.208 [ms] (mean)
Time per request:       420.110 [ms] (mean, across all concurrent requests)
Transfer rate:          2.24 [Kbytes/sec] received
```

### ノードを立ち上げ、メインのcelery4コア、ノードのceleryも4コア使用した場合

```txt
Concurrency Level:      20
Time taken for tests:   32.524 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      96153 bytes
HTML transferred:       68853 bytes
Requests per second:    3.07 [#/sec] (mean)
Time per request:       6504.811 [ms] (mean)
Time per request:       325.241 [ms] (mean, across all concurrent requests)
Transfer rate:          2.89 [Kbytes/sec] received
```

import duckdb


def main():
    # DuckDBデータベースに接続
    with duckdb.connect("/data/tpc-h/tpc-h.duckdb") as con:
        # テーブルとビューのリセット
        try:
            with open("/data/tpc-h/reset.sql", "r") as reset_file:
                reset_sql = reset_file.read()
                con.execute(reset_sql)
        except Exception:
            pass

        # テーブル定義を読み込む
        with open("/data/tpc-h/spec.sql", "r") as spec_file:
            spec_sql = spec_file.read()
            con.execute(spec_sql)

        # データを読み込んで1テーブルずつparquetを作成しそのビューとして読み込む
        # すべてduckdbデータベースにテーブルとして読み込むとメモリが不足する
        with open("/data/tpc-h/data.sql", "r") as data_file:
            data_sql = data_file.read()
            con.execute(data_sql)


if __name__ == "__main__":
    main()

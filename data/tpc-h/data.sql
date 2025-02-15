COPY PART FROM "/data/tpc-h/tbl/part.tbl" WITH (DELIMITER "|");
COPY (SELECT * FROM PART) TO "/data/tpc-h/parquet/part" (FORMAT "parquet", COMPRESSION "zstd", FILE_SIZE_BYTES 104857600, OVERWRITE);
DROP TABLE IF EXISTS PART CASCADE;
DROP VIEW IF EXISTS PART CASCADE;
CREATE VIEW PART AS (SELECT * FROM "/data/tpc-h/parquet/part/*.parquet");

COPY SUPPLIER FROM "/data/tpc-h/tbl/supplier.tbl" WITH (DELIMITER "|");
COPY (SELECT * FROM SUPPLIER) TO "/data/tpc-h/parquet/supplier" (FORMAT "parquet", COMPRESSION "zstd", FILE_SIZE_BYTES 104857600, OVERWRITE);
DROP TABLE IF EXISTS SUPPLIER CASCADE;
DROP VIEW IF EXISTS SUPPLIER CASCADE;
CREATE VIEW SUPPLIER AS (SELECT * FROM "/data/tpc-h/parquet/supplier/*.parquet");

COPY PARTSUPP FROM "/data/tpc-h/tbl/partsupp.tbl" WITH (DELIMITER "|");
COPY (SELECT * FROM PARTSUPP) TO "/data/tpc-h/parquet/partsupp" (FORMAT "parquet", COMPRESSION "zstd", FILE_SIZE_BYTES 104857600, OVERWRITE);
DROP TABLE IF EXISTS PARTSUPP CASCADE;
DROP VIEW IF EXISTS PARTSUPP CASCADE;
CREATE VIEW PARTSUPP AS (SELECT * FROM "/data/tpc-h/parquet/partsupp/*.parquet");

COPY CUSTOMER FROM "/data/tpc-h/tbl/customer.tbl" WITH (DELIMITER "|");
COPY (SELECT * FROM CUSTOMER) TO "/data/tpc-h/parquet/customer" (FORMAT "parquet", COMPRESSION "zstd", FILE_SIZE_BYTES 104857600, OVERWRITE);
DROP TABLE IF EXISTS CUSTOMER CASCADE;
DROP VIEW IF EXISTS CUSTOMER CASCADE;
CREATE VIEW CUSTOMER AS (SELECT * FROM "/data/tpc-h/parquet/customer/*.parquet");

COPY ORDERS FROM "/data/tpc-h/tbl/orders.tbl" WITH (DELIMITER "|");
COPY (SELECT * FROM ORDERS) TO "/data/tpc-h/parquet/orders" (FORMAT "parquet", COMPRESSION "zstd", FILE_SIZE_BYTES 104857600, OVERWRITE);
DROP TABLE IF EXISTS ORDERS CASCADE;
DROP VIEW IF EXISTS ORDERS CASCADE;
CREATE VIEW ORDERS AS (SELECT * FROM "/data/tpc-h/parquet/orders/*.parquet");

COPY LINEITEM FROM "/data/tpc-h/tbl/lineitem.tbl" WITH (DELIMITER "|");
COPY (SELECT * FROM LINEITEM) TO "/data/tpc-h/parquet/lineitem" (FORMAT "parquet", COMPRESSION "zstd", FILE_SIZE_BYTES 104857600, OVERWRITE);
DROP TABLE IF EXISTS LINEITEM CASCADE;
DROP VIEW IF EXISTS LINEITEM CASCADE;
CREATE VIEW LINEITEM AS (SELECT * FROM "/data/tpc-h/parquet/lineitem/*.parquet");

COPY NATION FROM "/data/tpc-h/tbl/nation.tbl" WITH (DELIMITER "|");
COPY (SELECT * FROM NATION) TO "/data/tpc-h/parquet/nation" (FORMAT "parquet", COMPRESSION "zstd", FILE_SIZE_BYTES 104857600, OVERWRITE);
DROP TABLE IF EXISTS NATION CASCADE;
DROP VIEW IF EXISTS NATION CASCADE;
CREATE VIEW NATION AS (SELECT * FROM "/data/tpc-h/parquet/nation/*.parquet");

COPY REGION FROM "/data/tpc-h/tbl/region.tbl" WITH (DELIMITER "|");
COPY (SELECT * FROM REGION) TO "/data/tpc-h/parquet/region" (FORMAT "parquet", COMPRESSION "zstd", FILE_SIZE_BYTES 104857600, OVERWRITE);
DROP TABLE IF EXISTS REGION CASCADE;
DROP VIEW IF EXISTS REGION CASCADE;
CREATE VIEW REGION AS (SELECT * FROM "/data/tpc-h/parquet/region/*.parquet");

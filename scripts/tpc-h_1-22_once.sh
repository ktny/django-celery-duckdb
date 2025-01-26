#!/bin/bash

for i in {1..22}
do
  echo "Query $i"
  curl "http://localhost:8000?q=$i"
done

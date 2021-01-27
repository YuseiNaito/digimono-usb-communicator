#!/usr/bin/env bash

while :
do
  read -p ">" input
  if [ -n "$input" ]; then
    python BME280/make_data.py $input
  fi
done


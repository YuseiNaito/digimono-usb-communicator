#!/usr/bin/env bash

while :
do
  read -p "error>" error
  if [ -n "$error" ]; then
    python BME280/make_data.py $error
  fi
done


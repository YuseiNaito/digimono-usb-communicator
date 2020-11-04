#!/usr/bin/env bash

if test -f sensor_a.csv; then
  mv sensor_a.csv test/sensor_a.csv
fi

touch sensor_a.csv

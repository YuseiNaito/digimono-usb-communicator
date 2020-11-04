#!/usr/bin/env bash

mkdir /mnt/usb1
mount /dev/sda1 /mnt/usb1
ls /mnt/usb1

if test -f sensor_a.csv; then
  mv sensor_a.csv /mnt/usb1/sensor_a.csv
fi

umount /mnt/usb1
rm -rf /mnt/usb1
touch sensor_a.csv

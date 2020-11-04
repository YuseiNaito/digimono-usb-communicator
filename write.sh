#!/usr/bin/env bash

mount_point=/mnt/usb1
device=/dev/sdb1

mkdir $mount_point
mount $device $mount_point

ls $mount_point

if test -f sensor_a.csv; then
  cp ./sensor_a.csv $mount_point/
  rm sensor_a.csv
fi

umount $mount_point
rm -rf $mount_point
touch sensor_a.csv

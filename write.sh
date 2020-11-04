#!/usr/bin/env bash

mount_point=/mnt/usb1
device=/dev/sdb1
filename=sensor_a.csv

while :
do
  if test -e $device; then
    mkdir $mount_point
    mount $device $mount_point

    if ! test -f $mount_point/$filename; then
      if test -f ./$filename; then
        cp ./$filename $mount_point/
        rm ./$filename
        echo 'Completed!'
      else
        echo 'Please remove old files.'
      fi

      touch ./$filename
    fi

    umount $mount_point
    rm -rf $mount_point

    sleep 1
  fi
done

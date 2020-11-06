#!/usr/bin/env bash

mount_point=/mnt/usb1
device=/dev/sdb1
filename=sensor_a.csv

finished=false

while :
do
  if ! test -e $device; then
    finished=false
  fi

  if test -e $device -a !$finished; then
    mkdir $mount_point
    mount $device $mount_point

    if ! test -f $mount_point/$filename; then
      if test -f ./$filename; then
        cp ./$filename $mount_point/
        rm ./$filename
        finished=true
        echo 'Completed!'
      fi
      touch ./$filename
    else
      echo 'Please remove old files.'
    fi

    umount $mount_point
    rm -rf $mount_point

    sleep 1
  fi
done

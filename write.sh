#!/usr/bin/env bash

# マウントするために作るディレクトリ
mount_point=/mnt/usb1
# デバイス(USBメモリなど)の場所
device=/dev/sdb1
# 取り出したいデータのファイル名
filename=sensor_a.csv
# 書き込みが完了したか
finished=false

while :
do
  if ! test -e $device; then
    # デバイスが抜かれたらフラグリセット
    finished=false
  fi

  if test -e $device -a ! $finished; then
    # デバイスが存在し、まだ書き込まれていなければマウント
    mkdir $mount_point
    mount $device $mount_point

    if ! test -f $mount_point/$filename; then
      # デバイスに同名ファイルが存在しなければ
      if test -f ./$filename; then
        # データが存在すればばデバイスに移動
        cp ./$filename $mount_point/
        rm ./$filename
        finished=true
        echo 'Completed!'
      fi
      # 新規ファイル作成
      touch ./$filename
    else
      # デバイスに同名ファイルが存在したら書き込まない
      echo 'Please remove old files.'
    fi

    # アンマウントし、マウント先のディレクトリを削除
    umount $mount_point
    rm -rf $mount_point

    sleep 1
  fi
done

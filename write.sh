#!/usr/bin/env bash

# マウントするために作るディレクトリ
mount_point=/mnt/usb1
# デバイス(USBメモリなど)のパス
device=/dev/sdb1
# 取り出したいデータのパス
file=sensor_a.csv
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
    if test -d $mount_point; then
      # マウントポイントが存在しなければ作成
      mkdir $mount_point
    fi
    mount $device $mount_point

    if ! test -f $mount_point/$file; then
      # デバイスに同名ファイルが存在しなければ
      if test -f $file; then
        # データが存在すればばデバイスに移動
        cp $file $mount_point/
        rm $file
        finished=true
        echo 'Completed!'
      fi
      # 新規ファイル作成
      touch ./$file
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

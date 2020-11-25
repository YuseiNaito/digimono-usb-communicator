#!/usr/bin/env bash

# マウントポイント
mount_point=/mnt/usb1
# デバイス(USBメモリなど)のパス
device=/dev/sda1
# 書き込みが完了したか
finished=false

while :
do
  read -p "error>" error
  python BME280/make_data.py $error

  sleep 1

  if [ ! -e $device ]; then
    # デバイスが抜かれたらフラグリセット
    finished=false
    continue
  fi

  if [ "$finished" = false ]; then
    # デバイスが存在し、まだ書き込まれていなければマウント
    if [ ! -d $mount_point ]; then
      # マウントポイントが存在しなければ作成
      mkdir $mount_point
    fi
    mount $device $mount_point
    ls $mount_point

    for file in $(ls *.csv);
    do
      if [ ! -f $mount_point/$file ]; then
        # デバイスに同名ファイルが存在しなければ
        if [ -f $file ]; then
          # データが存在すればばデバイスに移動
          cp $file $mount_point/
	  rm $file
          finished=true
          echo 'Completed!'
        fi
        # 新規ファイル作成
        touch $file
       else
         # デバイスに同名ファイルが存在したら書き込まない
         echo 'Please remove old files.'
       fi
    done

    # アンマウントし、マウントポイントを削除
    umount $mount_point
    rm -rf $mount_point
  fi
done

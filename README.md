# digimono-usb-communicator

## run.sh
`make_data.sh` , `write.sh` を同時に実行するスクリプトです。

### 使い方
 * , `make_data.sh` , `BME280/make_data.py` , `write.sh` の設定を行います。
 * root 権限で実行します。
 * USB メモリを接続すると、USB メモリ側に指定のファイルが移動されます。
     * すでにデバイス側に同名のファイルが存在する場合、上書きはされません。
 * 移動完了後、元の場所に同名の新規ファイルが生成されます。

### 出力
 * `write.sh` の標準出力、標準エラー出力は `/dev/null` に捨てられます。

## BME280/make_data.py
### 設定
 * `file_name` に任意のファイル名を指定します。(デフォルトは `sensor_a.csv`)
 * 必要があれば `bus_number` , `i2c_address` の設定を変更します。

## make_data.sh
`BME280/make_data.py` を実行し、CSV ファイルに値を出力します。形式は以下の通りです。

| 日時 [℃] | 気圧 [hPa] | 湿度 [%] | エラーコード | 
| ---- | ---- | ---- | ---- |

## write.sh
装置にUSBメモリなどのデバイスが接続された際に、デバイス側に指定のファイルを移動するスクリプトです。

### 設定
 * `mount_point` に指定されているディレクトリが存在しないことを確認します。存在していれば別の名前にします。
 * `device` にUSBメモリ等を接続した際のパスを指定します。
 * `file` 取り出したいファイルのパスを指定します。

### 出力
 * `Completed!`: 移動完了
 * `Please remove old files.`: デバイス内に同名ファイルが存在する

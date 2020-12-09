#!/bin/bash

trap killgroup INT

killgroup(){
  echo killing...
  kill 0
}

sh write.sh >/dev/null 2>&1 & sh make_data.sh
wait

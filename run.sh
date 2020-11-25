#!/bin/bash

trap killgroup INT

killgroup(){
  echo killing...
  kill 0
}

sh write.sh & sh make_data.sh
wait

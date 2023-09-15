#!/bin/bash

networkid=$1
port=$2
echo "host,port"
for hosts in {1..254}; do
  timeout .1 bash -c "echo > /dev/tcp/$networkid$hosts/$port" 2>/dev/null && echo "$networkid$hosts,$port"
done

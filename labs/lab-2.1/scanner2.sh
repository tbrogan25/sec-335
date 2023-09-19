#!/bin/bash

network_id=$1
portfile=$2
echo "host,port"
for hosts in {1..254}; do
  for ports in $(cat $portfile); do
    timeout .1 bash -c "echo > /dev/tcp/$network_id$hosts/$ports" 2>/dev/null && echo "$network_id$hosts,$ports"
  done
done

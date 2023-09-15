#!/bin/bash

network_id=$1

for ips in {1..254}
do
  bash -c "echo >/dev/tcp/'$network_id'ips/80" 2>/dev/null && echo 'hi if working'
done

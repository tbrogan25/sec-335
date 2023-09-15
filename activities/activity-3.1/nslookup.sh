#!/bin/bash

networkid=$1
dns_server=$2
for hosts in {1..254}; do
  reverse_lookup=$(nslookup $networkid$hosts $dns_server)
  if echo $reverse_lookup | grep 'name'
  then
    echo $reverse_lookup
  else
    continue
  fi
done

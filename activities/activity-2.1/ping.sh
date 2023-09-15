#!/bin/bash

# Goal:
# Ping IP addresses in the range 10.0.5.2 - 10.0.5.50
# Print out all responding IPs

# For each host ID in the IP range...
for ip in {2..50}
do
  # ...ping each IP with a given network ID
  pings=$(ping -c 1 -q -w 1 10.0.5.$ip)
  # If the ping succeeds, then print the IP
  if echo $pings | grep -q -w "0% packet loss"
  then
    echo 10.0.5.$ip >> sweep.txt
  else
    continue
  fi
done

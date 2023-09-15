#!/bin/bash

for ip in {2..50}
do
  scan=$(nmap -sn 10.0.5.$ip)
  if echo $scan | grep "Host is up"
  then
    echo "10.0.5.$ip" >> sweep3.txt
  else
    continue
  fi
done 

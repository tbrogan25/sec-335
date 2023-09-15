#! /bin/bash
input=/home/champuser/Documents/metagoo_out/activity-1.2.txt
counter=0
while read -r line
do
curl ${line} -o "/home/champuser/Documents/metagoo_out/${counter}"
let counter++
done < ${input}

#!/bin/bash

# Goal:
# Input network address and subnet mask to have all hosts scanned
# Subgoal:
# Upon receiving CIDR notation (/24; /25; etc/),
# Calculate the number of hosts to scan with the for loop

# Subgoal:
# Have user input full network ID/netmask, and awk/sed the different values
# Convert IP address to binary
# Convert subnet mask into binary
# Separate the 1s from 0s
# Count the 0s in each octet and determine the largest decimal number possible (11111000 == (2^3 - 2) == 6)
# The above example is accurate only if it is the last octet
# If any other octet to the left of the last one, determine the largest dec number possible too but (11111000 == (2^3) == 8)
# Use those decimal numbers to make a list of scannable IPs. Add the network ID to a for loop that uses all of the possible combinations from the subnet mask

subnet=$1

# Cut the network address from the netmask
network_address=$(awk -F '/' '{print $1}' <<< $subnet)
cidr=$(awk -F '/' '{print $2}' <<< $subnet)

# Convert each octet into binary
octet_1=$(bc <<< "obase=2" <<< $(awk -F '.' '{print $1}' <<< $network_address))
octet_2=$(bc <<< "obase=2" <<< $(awk -F '.' '{print $2}' <<< $network_address))
octet_2=$(bc <<< "obase=2" <<< $(awk -F '.' '{print $3}' <<< $network_address))
octet_4=$(bc <<< "obase=2" <<< $(awk -F '.' '{print $4}' <<< $network_address))

# if binary octet == 0, then set to 254 hosts for that octet

#read network_id <<< $(awk -F '.' '{print $1, $2, $3, $4}' <<< "$network_address")
#ports=$3

host_bits=$((32 - $cidr))
hosts=$(((2**$host_bits) - 2))
 
echo "host,port"
#for ips in {1..$hosts}; do
for (( ips=1; ips<=$hosts; ips++ )); do 
 #for ports in $(cat $portfile); do
  timeout .1 bash -c "echo > /dev/tcp/'10.0.5.''$ips'/80" 2>/dev/null && echo "10.0.5.$ips port 80 is open!"
  #echo $ips
done

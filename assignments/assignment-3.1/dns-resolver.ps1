# Goal:
# Perform DNS reverse lookups for every host on a /24 network
# 1. Allow positional parameters for the network ID & DNS server
# 2. Use the 'resolve-dnsname' cmdlet in a 'for loop' to resolve all 254 hosts

param (
   [Parameter(Position=0)]
   [string]$networkID,

   [Parameter(Position=1)]
   [string]$dnsServer
 )

for ($hosts=0; $hosts -ne 254; $hosts++)
{
  # $host = $networkID + $hosts
  resolve-dnsname -dnsonly $networkID$hosts -server $dnsServer -erroraction ignore | Select-Object @{Name="NameHost"; Expression={($networkID + $hosts) + ',' + $_.NameHost}}

}




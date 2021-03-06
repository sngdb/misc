#!/bin/bash
# This script is a wrapper around the vulnscan.nse project to work more efficiently and have a more organized output. Uses exploit-db.
# http://www.computec.ch/projekte/vulscan/?
# https://www.exploit-db.com/
# This will be noisy, so pick your subnet carefully.

echo Enter IP or CIDR range
read ip

mkdir vulns

echo Parsing online hosts...
nmap -PR -sP -PM -PE -PS -R $ip | grep "Host is up" -B 1 | grep "Nmap scan" | cut -d " " -f 5 >./vulns/online.txt

echo Beginning vulnerability scan...
for scan in $(cat ./vulns/online.txt);do nmap -sS -sV --script=vulscan/vulscan.nse --script-args vulscandb=exploitdb.csv $scan | grep -v Denial >./vulns/$scan-vulns.txt & done

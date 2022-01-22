#!/bin/sh

mkdir output
cat refs/blocklist-ipsets/fire*.*set|grep -v "#" > hol.tmp.txt
cat refs/ipsum/ipsum.txt | grep -v "#" | grep -v -E "\s[1-2]$" | cut -f 1 > ipsum.tmp.txt
iprange hol.tmp.txt ipsum.tmp.txt refs/zzz/ipset.txt refs/zzz/netset.txt > tmp.txt
grep "/" tmp.txt > net.tmp.txt
iprange net.tmp.txt --optimize > output/netset.txt
iprange refs/zzz/ipset.txt output/netset.txt > tmp.txt
grep -v "/" tmp.txt > ip.tmp.txt
iprange ip.tmp.txt --optimize > output/ipset.txt
rm *tmp.txt


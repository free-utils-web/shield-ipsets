#!/bin/sh

cat ../refs/blocklist-ipsets/*.*set|grep -v "#" > hol.tmp.txt
iprange hol.tmp.txt ../refs/zzz/ipset.txt ../refs/zzz/netset.txt > tmp.txt
grep "/" tmp.txt > net.tmp.txt
grep -v "/" tmp.txt > ip.tmp.txt
iprange net.tmp.txt --optimize > netset.txt
iprange ip.tmp.txt --optimize > ipset.txt
rm *tmp.txt


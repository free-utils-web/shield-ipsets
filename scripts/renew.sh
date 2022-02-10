#!/bin/sh

git submodule foreach 'git reset --hard;git fetch origin master;git checkout master --force'
mkdir output
cat refs/blocklist-ipsets/*abuse*.*set|grep -v "#" > hol.tmp.txt
cat refs/blocklist-ipsets/*spam*.*set|grep -v "#" >> hol.tmp.txt
cat refs/blocklist-ipsets/*shield*.*set|grep -v "#" >> hol.tmp.txt
cat refs/blocklist-ipsets/*bad*.*set|grep -v "#" >> hol.tmp.txt
cat refs/blocklist-ipsets/*black*.*set|grep -v "#" >> hol.tmp.txt
cat refs/blocklist-ipsets/*malic*.*set|grep -v "#" >> hol.tmp.txt
cat refs/blocklist-ipsets/*attac*.*set|grep -v "#" >> hol.tmp.txt
cat refs/blocklist-ipsets/*bot*.*set|grep -v "#" >> hol.tmp.txt
cat refs/blocklist-ipsets/*ads*.*set|grep -v "#" >> hol.tmp.txt
cat refs/blocklist-ipsets/*chain*.*set|grep -v "#" >> hol.tmp.txt
cat refs/blocklist-ipsets/firehol_level2.*set|grep -v "#" >> hol.tmp.txt
cat refs/blocklist-ipsets/firehol_level3.*set|grep -v "#" >> hol.tmp.txt
cat refs/blocklist-ipsets/firehol_level4.*set|grep -v "#" >> hol.tmp.txt
cat refs/blocklist-ipsets/firehol_ano*.*set|grep -v "#" >> hol.tmp.txt
cat refs/blocklist-ipsets/*prox*.*set|grep -v "#" >> hol.tmp.txt
cat refs/blocklist-ipsets/firehol_webclient.*set|grep -v "#" >> hol.tmp.txt
cat refs/blocklist-ipsets/*fraud*.*set|grep -v "#" >> hol.tmp.txt
cat refs/ipsum/ipsum.txt | grep -v "#" | grep -v -E "\s[1-2]$" | cut -f 1 > ipsum.tmp.txt
iprange hol.tmp.txt ipsum.tmp.txt refs/zzz/ipset.txt refs/zzz/netset.txt --except refs/zzz/white.txt > tmp.txt
grep "/" tmp.txt > net.tmp.txt
iprange net.tmp.txt --optimize > output/netset.txt
iprange ipsum.tmp.txt refs/zzz/ipset.txt output/netset.txt > tmp.txt
grep -v "/" tmp.txt > ip.tmp.txt
iprange ip.tmp.txt --optimize > output/ipset.txt
rm *tmp.txt


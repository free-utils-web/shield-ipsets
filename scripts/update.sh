#!/bin/sh

mv output/netset.txt output/netset.bak
mv output/ipset.txt output/ipset.bak
. scripts/renew.sh
diff output/netset.bak output/netset.txt > output/netset.diff
cat output/netset.diff | grep "<" | awk -F ' ' '{print $2}' > output/netset.del
cat output/netset.diff | grep ">" | awk -F ' ' '{print $2}' > output/netset.add
diff output/ipset.bak output/ipset.txt > output/ipset.diff
cat output/ipset.diff | grep "<" | awk -F ' ' '{print $2}' > output/ipset.del
cat output/ipset.diff | grep ">" | awk -F ' ' '{print $2}' > output/ipset.add
for ip in $(cat output/ipset.del);do ipset del badip $ip;done
for net in $(cat output/netset.del);do ipset del badnet $net;done
for net in $(cat output/netset.add);do ipset add badnet $net;done
for ip in $(cat output/ipset.add);do ipset add badip $ip;done
netfilter-persistent save


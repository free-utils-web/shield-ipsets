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
echo "" > output/count.txt
count=$(cat output/netset.del|wc -l); echo "netset.del $count" >> output/count.txt
count=$(cat output/ipset.del|wc -l); echo "ipset.del $count" >> output/count.txt
count=$(cat output/netset.add|wc -l); echo "netset.add $count" >> output/count.txt
count=$(cat output/ipset.add|wc -l); echo "ipset.add $count" >> output/count.txt
cat count.txt | sort -t" " -nk2


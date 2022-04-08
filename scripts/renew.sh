#!/bin/sh

git submodule foreach 'git reset --hard;git fetch origin master;git checkout master --force'
mkdir output
echo "" > hol.tmp.txt

for file in $(ls refs/blocklist-ipsets/*.*set | grep -E 'abuse|spam|shield|bad|black|dark|mal|attac|bot|ads|ssl|threat|tor|coin|bl\.|chain|crypto|firehol_level2|firehol_level3|firehol_level4|firehol_ano|rox|firehol_webclient|vir|worm|crim|army|force|fraud|ssh|hphost|nullsecure|talos|blam|greensnow|snort|grey|feodo|taichung|cobra|ponmo|phish|bbcan177|bds_atif|packetmail|et_compromised|graphiclineweb|vxvault|gpf|ranso|urando|php|cleantalk|bambenek|myip|et_block|esentire|reputation|blocklist_de|blocklist_net_ua')
  do cat $file | grep -v "#" >> hol.tmp.txt
done

cat refs/ipsum/ipsum.txt | grep -v "#" | grep -v -E "\s[1-2]$" | cut -f 1 > ipsum.tmp.txt
iprange hol.tmp.txt ipsum.tmp.txt refs/zzz/ipset.txt refs/zzz/netset.txt --except refs/zzz/white.txt > tmp.txt
grep "/" tmp.txt > net.tmp.txt
iprange net.tmp.txt --optimize > output/netset.txt
#iprange ipsum.tmp.txt refs/zzz/ipset.txt output/netset.txt > tmp.txt
grep -v "/" tmp.txt > ip.tmp.txt
iprange ip.tmp.txt --optimize > output/ipset.txt
rm *tmp.txt


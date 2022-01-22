#!/bin/sh

grep -E "invalid user|Failed password|Unable to negotiate" /var/log/auth.log* > auth.bad.txt
grep 'invalid' auth.bad.txt | awk -F 'from ' '{print $2}' | awk -F ' port' '{print $1}' | grep -v 'HNAP' | awk -F ' ' '{print $4}' | iprange > invalid.txt
grep 'invalid' auth.bad.txt | awk -F 'from ' '{print $2}' | awk -F ' port' '{print $1}' | grep 'HNAP' | awk -F ' ' '{print $5}' | iprange >> invalid.txt
grep 'Unable to negotiate' auth.bad.txt | awk -F 'with ' '{print $2}' | awk -F ' port' '{print $1}' | iprange > nego.txt
grep -v -E "invalid|negotiate" auth.bad.txt | awk -F 'from ' '{print $2}'|grep -v 'invalid'|awk -F ' ' '{print $1}' | iprange > failed.txt
cat /etc/hosts.deny|awk -F ': ' '{print $2}' > deny.txt
iprange invalid.txt nego.txt failed.txt deny.txt --optimize > bad.txt
iprange -1 bad.txt > bad.ips.txt
echo "" > count.txt
for ip in $(cat bad.txt);do count=$(grep "$ip" auth.bad.txt|wc -l); echo "$ip $count" >> count.txt;done
cat count.txt | sort -t" " -nk2
grep "/" bad.txt > ssh.badnet.txt
grep -v "/" bad.txt > ssh.badip.txt


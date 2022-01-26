#!/bin/sh

iprange output/web.badip.txt output/ssh.badip.txt output/ssh.badnet.txt refs/zzz/ipset.txt refs/zzz/netset.txt > zzz.tmp.txt
iprange zzz.tmp.txt --optimize > zzz.tmp.o.txt
grep "/" zzz.tmp.o.txt > refs/zzz/netset.txt
grep -v "/" zzz.tmp.o.txt > refs/zzz/ipset.txt
rm *tmp*


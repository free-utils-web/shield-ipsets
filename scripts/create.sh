#!/bin/sh

ipset create badnet hash:net maxelem 131072
ipset create badip hash:ip
iptables -I INPUT -i eth0 -m set --match-set badnet src -j DROP
iptables -I DOCKER-USER -i eth0 -m set --match-set badnet src -j DROP
iptables -I INPUT -i eth0 -m set --match-set badip src -j DROP
iptables -I DOCKER-USER -i eth0 -m set --match-set badip src -j DROP
for var in `cat badnet`;do ipset add badnet $var;done
for var in `cat badip`;do ipset add badip $var;done


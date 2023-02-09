#!/bin/sh

for ip in $(cat ipset.del);do ipset del badip $ip;done
for net in $(cat netset.del);do ipset del badnet $net;done
for net in $(cat netset.add);do ipset add badnet $net;done
for ip in $(cat ipset.add);do ipset add badip $ip;done
ipset save > ipsets.v6


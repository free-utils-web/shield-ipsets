#!/bin/sh

ipset flush badnet
ipset flush badip
for var in `cat netset.txt`;do ipset add badnet $var;done
for var in `cat ipset.txt`;do ipset add badip $var;done


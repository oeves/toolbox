#!/bin/bash

# download latest mac database and tries to get the vendor
# requires ethtool - should replace with ifconfig

# update mac address database - if changed
wget --quiet -N -T2 -t1 http://standards-oui.ieee.org/oui.txt

# get local mac address, convert it to base16, split the vendor part, make it uppercase and grep the vendor
LOCALMAC=$(ethtool -P eth0 | cut -d " " -f 3 | tr -d ":")
LOCALMACVENDOR=$(echo $LOCALMAC | cut -c 1-6 | tr 'a-z' 'A-Z')
LOCALVENDOR=$(cat $(echo ${0##*/}.db) | grep $(echo $LOCALMACVENDOR) | cut  -f3 -s)

echo $LOCALVENDOR

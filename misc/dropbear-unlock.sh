#!/bin/sh

# script to unlock a luks encrypted machine via dropbear

ssh -o "UserKnownHostsFile=~/.ssh/known_hosts.dropbear" \
    -i "id_dropbear" root@remotehost \
    "echo -ne \"verySTRONGpasswordINhereLEAVEtheSLASHwhereITis\" >/lib/cryptsetup/passfifo"

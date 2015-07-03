#! /bin/bash

if [ "$(whoami)" != 'root' ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

set -e #Causes the script to exit on the first failure

PASS=""
echo -n "Enter password: "
read -s PASS
echo ""

openssl aes-256-cbc -a -d -pass pass:$PASS -in ./murray.conf -out ./decrypted.conf

cat decrypted.conf > /etc/wpa_supplicant/wpa_supplicant.conf
rm decrypted.conf

ifdown wlan0
ifup wlan0

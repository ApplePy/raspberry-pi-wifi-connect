#! /bin/bash

if [ "$(whoami)" != 'root' ]; then
   echo "This script should be run as root" 1>&2
   exit 1
fi

set -e #Causes the script to exit on the first failure

PASS1=""
PASS2=""
echo -n "Enter new password: "
read -s PASS1
echo ""

echo -n "Enter password again: "
read -s PASS2
echo ""

if [ "$PASS1" != "$PASS2" ]; then
    echo "The passwords do not match!" 1>&2
    rm ./decrypted.conf
    exit 2
fi

openssl aes-256-cbc -a -e -pass pass:$PASS1 -out ./murray.conf -in /etc/wpa_supplicant/wpa_supplicant.conf

chmod 666 ./murray.conf

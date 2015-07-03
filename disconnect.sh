#! /bin/sh

if [ "$(whoami)" != 'root' ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

cat normal.conf > /etc/wpa_supplicant/wpa_supplicant.conf

ifdown wlan0
ifup wlan0

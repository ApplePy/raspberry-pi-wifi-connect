#! /bin/bash

if [ "$(whoami)" != 'root' ]; then
   echo "This script should be run as root" 1>&2
   exit 1
fi


NAME=""

#if arguement supplied, use supplied last name, else ask for it
if [ $# -eq 0 ]; then
    echo -n "Enter last name: "
    read NAME
else
    NAME=$1
fi

#Check if file exists
if [  -f "$NAME.conf" ]; then
    echo "Your name has already been set up. Delete $NAME.conf first." 1>&2
    exit 3
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
    exit 2
fi

openssl aes-256-cbc -a -e -pass pass:$PASS1 -out ./$NAME.conf -in ./template.config 

chmod 666 ./$NAME.conf
chown pi: ./$NAME.conf


echo ""
echo ""
echo "Starting configuration..."
sudo -u pi bash -c "./change_wifi_networks.sh $NAME"

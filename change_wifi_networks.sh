#! /bin/bash

if [ "$(whoami)" = 'root' ]; then
   echo "This script should not be run as root" 1>&2
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
if [  ! -f "$NAME.conf" ]; then
    echo "Your name hasn't been set up yet. Run \"setup.sh\" to get started." 1>&2
    exit 3
fi


set -e #Causes the script to exit on the first failure

PASS=""

echo -n "Enter password: "
read -s PASS
echo ""

openssl aes-256-cbc -a -d -pass pass:$PASS -in ./$NAME.conf -out ./$NAME_decrypted.conf

editor ./$NAME_decrypted.conf

openssl aes-256-cbc -a -e -pass pass:$PASS -out ./$NAME.conf -in ./$NAME_decrypted.conf

rm ./$NAME_decrypted.conf

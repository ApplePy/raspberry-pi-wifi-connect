#Raspberry Pi Wifi Connect

This tool consists of some scripts to automate connecting and disconnecting to private wifi networks on a shared Raspberry Pi. This tool uses wpa supplicant to manage wifi settings, and openSSL to securely encrypt each user's wifi settings.

##Usage

Run "setup.sh" to begin setting up your wifi network settings.

Run "connect.sh" to connect to your private wifi network, and "disconnect.sh" to disconnect from your private wifi network before handing the Raspberry Pi off to someone new.

##Troubleshooting

If you forgot your password or otherwise are having issues, deleting your configuration file and starting anew is your best option (and your only option if you forgot your password).

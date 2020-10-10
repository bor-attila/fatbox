#!/bin/bash

# Raw start ?
# sudo -i
# echo vagrant ALL=NOPASSWD:ALL > /etc/sudoers.d/vagrant
# apt -y update && apt -y upgrade && apt -y autoremove
# apt -y install linux-headers-$(uname -r) build-essential dkms
# mount /dev/cdrom /media
# sh /media/VBoxLinuxAdditions.run
# shutdown -r now

#generate some base directories and ssl keys
mkdir ~/.ssl
mkdir ~/www
mkdir ~/logs
openssl req -x509 -nodes -newkey rsa:4096 -keyout ~/.ssl/key.pem -out ~/.ssl/cert.pem -days 3650
#!/bin/bash

echo "Installing Dart ..."

sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -'
sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
sudo apt -y update && sudo apt -y upgrade
sudo apt -y install dart
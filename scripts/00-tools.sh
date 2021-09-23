#!/bin/bash

echo "Initialization and installing tools ..."

sudo apt -y update && \
sudo apt -y upgrade && \
sudo apt -y autoremove && \
sudo apt -y install htop mc unrar net-tools cmake wget curl gnupg-agent apt-transport-https make gcc
#!/bin/bash

echo "Installing NodeJS ..."

curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
rm nodesource_setup.sh
sudo apt -y install nodejs

## Yarn & company
sudo npm install -g yarn grunt-cli grunt sass webpack gulp webpack-cli
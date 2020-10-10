#!/bin/bash

sudo apt -y autoremove
sudo apt clean
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY
sudo cat /dev/null > ~/.bash_history
sudo history -c 
history -c
exit
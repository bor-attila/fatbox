#!/bin/bash

echo "Installing mailhog ..."

go get github.com/mailhog/MailHog
sudo ln -s ~/go/bin/MailHog /usr/local/bin/mailhog
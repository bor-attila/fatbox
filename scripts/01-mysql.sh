#!/bin/bash

echo "Installing MySQL ..."

sudo apt -y install mysql-common mysql-server mysql-client libmysql++-dev
sudo sed -ri "s/bind-address\s+= 127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql
cat << InitScript > /tmp/init.sql
CREATE USER 'vagrant'@'%' IDENTIFIED BY 'vagrant';
GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
InitScript

sudo mysql < /tmp/init.sql
#!/bin/bash

echo "Installing PHP ..."

php_version="8.0"

## Add repo
sudo add-apt-repository -y ppa:ondrej/php && \
sudo apt -y update && \
sudo apt -y upgrade

sudo apt -y install php-common php-dev php-apcu php-curl php-gd php-intl php-igbinary php-imagick php-ldap php-xml php-mbstring php-memcached php-memcache php-json php-mysql php-sqlite3 php-bz2 php-zip php-mongodb
sudo apt -y install php$php_version-fpm

## PHP Odbc
# https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver15#ubuntu17

curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo sh -c "curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list"
sudo apt -y update && sudo apt -y upgrade
sudo ACCEPT_EULA=Y apt -y install msodbcsql17
sudo ACCEPT_EULA=Y apt -y install mssql-tools
sudo apt -y install unixodbc-dev php-odbc

# https://docs.microsoft.com/en-us/sql/connect/php/installation-tutorial-linux-mac?view=sql-server-ver15#installing-the-drivers-on-ubuntu-1604-1804-and-2004
#pecl config-set php_ini /etc/php/7.4/fpm/php.ini
sudo mkdir -p /tmp/pear/cache
sudo update-alternatives --set php /usr/bin/php$php_version
sudo pecl install sqlsrv pdo_sqlsrv
sudo sh -c "sudo printf \"; priority=20\nextension=sqlsrv.so\n\" > /etc/php/$php_version/mods-available/sqlsrv.ini"
sudo sh -c "sudo printf \"; priority=30\nextension=pdo_sqlsrv.so\n\" > /etc/php/$php_version/mods-available/pdo_sqlsrv.ini"
sudo phpenmod -v $php_version sqlsrv pdo_sqlsrv

#echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
#echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
#source ~/.bashrc

# PHP FPM config
sudo sed -i "s/user = www-data/user = vagrant/" /etc/php/$php_version/fpm/pool.d/www.conf
sudo sed -i "s/group = www-data/group = vagrant/" /etc/php/$php_version/fpm/pool.d/www.conf
sudo sed -i "s/listen.owner = www-data/listen.owner = vagrant/" /etc/php/$php_version/fpm/pool.d/www.conf
sudo sed -i "s/listen.group = www-data/listen.group = vagrant/" /etc/php/$php_version/fpm/pool.d/www.conf
sudo systemctl restart "php$php_version-fpm"

# PHP INI
sudo sed -i "s/post_max_size = 8M/post_max_size = 1000M/" /etc/php/$php_version/fpm/php.ini
sudo sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 1000M/" /etc/php/$php_version/fpm/php.ini
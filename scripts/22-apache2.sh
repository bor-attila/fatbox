#!/bin/bash

echo "Installing apache2 ..."

## Apache 2.x
sudo apt -y install apache2 passenger libapache2-mod-passenger
sudo a2enmod rewrite ssl proxy proxy_fcgi env passenger
sudo systemctl restart apache2

#apache2 config
sudo sh -c 'echo "User vagrant" > /etc/apache2/conf-available/custom.conf'
sudo sh -c 'echo "Group vagrant" >> /etc/apache2/conf-available/custom.conf'
sudo a2enconf custom
sudo a2enconf php8.0-fpm
sudo systemctl restart apache2


# Site settings
cd /etc/apache2/sites-enabled && sudo a2dissite *

cd /etc/apache2/sites-available && sudo rm *

cat << ApacheSite > /tmp/default.conf
<VirtualHost *:80>
        ServerName vagrant.local
        ServerAdmin attila@smartwebservices.eu

        RewriteEngine On
        RewriteCond %{HTTPS} off
        RewriteRule (.*) https://%{SERVER_NAME}$1 [R,L]
</VirtualHost>

<VirtualHost *:80>
        ServerName vagrant.ruby
        ServerAdmin attila@smartwebservices.eu

        RewriteEngine On
        RewriteCond %{HTTPS} off
        RewriteRule (.*) https://%{SERVER_NAME}$1 [R,L]
</VirtualHost>

<IfModule mod_ssl.c>
        <VirtualHost *:443>
                ServerName vagrant.local
                ServerAdmin attila@smartwebservices.eu

                DocumentRoot /home/vagrant/www/
                <Directory /home/vagrant/www/>
                    Options +FollowSymlinks -Indexes -MultiViews
                    Require all granted
                    AllowOverride all
                </Directory>

                ErrorLog /home/vagrant/logs/apache-error.log
                CustomLog /home/vagrant/logs/apache-access.log combined

                SSLEngine on
                SSLCertificateFile  /home/vagrant/.ssl/cert.pem
                SSLCertificateKeyFile /home/vagrant/.ssl/key.pem
                
                SetEnvIf Authorization "(.*)" HTTP_AUTHORIZATION=$1
                IncludeOptional /home/vagrant/www/config/.env.apache
                IncludeOptional /home/vagrant/www/.env.apache

                <FilesMatch "\.(cgi|shtml|phtml|php)$">
                    SSLOptions +StdEnvVars
                </FilesMatch>

                <Directory /usr/lib/cgi-bin>
                    SSLOptions +StdEnvVars
                </Directory>
        </VirtualHost>

        <VirtualHost *:443>
                ServerName vagrant.ruby
                ServerAdmin attila@smartwebservices.eu

                DocumentRoot /home/vagrant/ruby/

                PassengerRuby /usr/bin/ruby

                <Directory /home/vagrant/ruby/>
                    Options +FollowSymlinks -Indexes -MultiViews
                    Require all granted
                    AllowOverride all
                </Directory>

                ErrorLog /home/vagrant/logs/apache-error.log
                CustomLog /home/vagrant/logs/apache-access.log combined

                SSLEngine on
                SSLCertificateFile  /home/vagrant/.ssl/cert.pem
                SSLCertificateKeyFile /home/vagrant/.ssl/key.pem
                
                SetEnvIf Authorization "(.*)" HTTP_AUTHORIZATION=$1
                IncludeOptional /home/vagrant/ruby/config/.env.apache
                IncludeOptional /home/vagrant/ruby/.env.apache

                <FilesMatch "\.(cgi|shtml|phtml|php)$">
                    SSLOptions +StdEnvVars
                </FilesMatch>

                <Directory /usr/lib/cgi-bin>
                    SSLOptions +StdEnvVars
                </Directory>
        </VirtualHost>
</IfModule>
ApacheSite

sudo mv /tmp/default.conf /etc/apache2/sites-available/default.conf

sudo a2ensite default
sudo systemctl restart apache2
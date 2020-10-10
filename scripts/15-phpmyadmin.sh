#!/bin/bash

echo "Installing phpMyAdmin ..."

wget https://files.phpmyadmin.net/phpMyAdmin/4.9.6/phpMyAdmin-4.9.6-all-languages.tar.gz -O pma.tar.gz
tar -xf pma.tar.gz
rm pma.tar.gz
mv phpMyAdmin-4.9.6-all-languages phpmyadmin

cat << Config > /tmp/config.inc.php
<?php
\$cfg['blowfish_secret'] = 'S1DYyz0S0ObYyyxIWCQ36BY7xuHM5sst8YONwZgE';
\$i = 0;
\$i++;
\$cfg['Servers'][$i]['auth_type'] = 'cookie';
\$cfg['Servers'][$i]['host'] = 'localhost';
\$cfg['Servers'][$i]['compress'] = false;
\$cfg['Servers'][$i]['AllowNoPassword'] = false;
Config

sudo mv /tmp/config.inc.php /home/vagrant/phpmyadmin/config.inc.php

cat << Config > /tmp/phpmyadmin.conf
# phpMyAdmin default Apache configuration

Alias /phpmyadmin /home/vagrant/phpmyadmin/

<Directory /home/vagrant/phpmyadmin/>
    Options SymLinksIfOwnerMatch
    DirectoryIndex index.php
    Require all granted
    AllowOverride all

    # limit libapache2-mod-php to files and directories necessary by pma
    # <IfModule mod_php7.c>
    #    php_admin_value upload_tmp_dir /var/lib/phpmyadmin/tmp
    #    php_admin_value open_basedir /usr/share/phpmyadmin/:/etc/phpmyadmin/:/var/lib/phpmyadmin/:/usr/share/php/php-gettext/:/usr/share/php/php-php-gettext/:/usr/share/javascript/:/usr/share/php/tcpdf/:/usr/share/doc/phpmyadmin/:/usr/s>
    # </IfModule>

</Directory>

# Disallow web access to directories that don't need it
<Directory /home/vagrant/phpmyadmin/templates>
    Require all denied
</Directory>
<Directory /home/vagrant/phpmyadmin/libraries>
    Require all denied
</Directory>
Config

sudo mv /tmp/phpmyadmin.conf /etc/apache2/conf-available/phpmyadmin.conf

sudo a2enconf phpmyadmin
sudo systemctl restart apache2
atee's fatbox
===

All vagrant box should be small as possible, but this ... this is fat.

Base image: [bento/ubuntu-20.04](https://app.vagrantup.com/bento/boxes/ubuntu-20.04)  
Final image download link: [atee/fatbox](https://app.vagrantup.com/atee/boxes/fatbox)

The image contains all script results.

1. Run `sh init.sh`
2. Run `./install.sh .` or `./install.sh fileregex`

Where `fileregex` if a regex pattern.

# Contains

## Tools available:  
htop, mc, unrar, net-tools, cmake, wget, curl, mssql-tools, wkhtmltopdf (0.12.6 (with patched qt)) 

## Databases:  
- MySQL 8  
Listening on: 0.0.0.0:3306  
user:vagrant pass:vagrant (with all access from any host + grant option)  
Developent library included  
- SQLlite 3

## PHP 7.4
PHP 7.4 FPM + CLI  
Uploads maximized to 1000M  
PhpMyadmin 4.9.6  
PHP extensions: apc, apcu, bz2, calendar, Core, ctype, curl, date, dom, exif, FFI, fileinfo, filter, ftp, gd, gettext, hash, iconv, igbinary, imagick, intl, json, ldap, libxml, mbstring, memcache, memcached, mongodb, msgpack, mysqli, mysqlnd, odbc, openssl, pcntl, pcre, PDO, pdo_mysql, PDO_ODBC, pdo_sqlite, pdo_sqlsrv, Phar, posix, readline, Reflection, session, shmop, SimpleXML, sockets, sodium, SPL, sqlite3, sqlsrv, standard, sysvmsg, sysvsem, sysvshm, tokenizer, xml, xmlreader, xmlwriter, xsl, Zend OPcache, zip, zlib  

## Memcached
memcached 1.5.22
Listening on: 127.0.0.1:11211

## Composer
Composer version 1.10.13  
Installed globally, just use: `composer`

## Dart
Dart SDK version: 2.10.1 (stable) (Unknown timestamp) on "linux_x64"

## GoLang
go version go1.13.8 linux/amd64

## Nodejs 14.x
Also installed (globally):
+ webpack@5.0.0
+ grunt-cli@1.3.2
+ sass@1.27.0
+ gulp@4.0.2
+ grunt@1.3.0
+ webpack-cli@4.0.0
+ yarn@1.22.10

## OpenJDK JRE-14
openjdk 14.0.1 2020-04-14
OpenJDK Runtime Environment (build 14.0.1+7-Ubuntu-1ubuntu1)
OpenJDK 64-Bit Server VM (build 14.0.1+7-Ubuntu-1ubuntu1, mixed mode, sharing)

Also installed: Maven 3
Apache Maven 3.6.3

## Apache 2.4  
Mounted to: _/home/vagrant/www/_  
_Tip:_  
The apache automatically searches the `~/www/.env` and the `~/www/config/.env` file to include  
You can set the enviroment variables here like: `SetEnv VARIABLE_NAME VARIABLE_VALUE`

## Sphinx Search 3.3.1
The searchd and the indexer not started, you must start manually.  
`~/sphinx/bin/searchd your.conf`  
`~/sphinx/bin/indexer your.conf --rotate --all`

## MailHog
Start with: `mailhog`  

## Docker
Docker version 19.03.13, build 4484c46d9d

## Other
Random SSL keys generated to ./ssl directory  
gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04)  
libboost-dev-all installed  
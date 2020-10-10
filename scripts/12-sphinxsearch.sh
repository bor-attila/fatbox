#!/bin/bash

echo "Installing sphinxsearch ..."

wget http://sphinxsearch.com/files/sphinx-3.3.1-b72d67b-linux-amd64.tar.gz -O sphinx.tar.gz
tar -xf sphinx.tar.gz
rm sphinx.tar.gz
mv sphinx-3.3.1 sphinx

## Set SQL server driver name
echo "[SQL Server]" > /tmp/odbc
sudo tail -n 4 /etc/odbcinst.ini >> /tmp/odbc
sudo cat /tmp/odbc >> /etc/odbcinst.ini
rm -f /tmp/odbc

#add mssql-tools to vagrant user
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
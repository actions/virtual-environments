#!/bin/bash
################################################################################
##  File:  mysql.sh
##  Desc:  Installs MySQL Client
################################################################################


export ACCEPT_EULA=Y

if isUbuntu16 || isUbuntu18 ; then
    apt-get install mysql-client -y
fi

if isUbuntu20 ; then
    # Install mysql 8 for Ubuntu 20.

    debconf-set-selections <<< 'mysql-apt-config mysql-apt-config/select-server select mysql-8.0'
    package_version=$(curl https://dev.mysql.com/downloads/repo/apt/ 2> /dev/null | grep "\.deb" | awk -F "[()]" '{print $2}')
    wget https://dev.mysql.com/get/$package_version
    dpkg -i $package_version
    apt update
fi

# Mysql setting up root password
MYSQL_ROOT_PASSWORD=root
echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | debconf-set-selections

# Install MySQL Server
apt-get install -y mysql-server

#Install MySQL Dev tools
apt install libmysqlclient-dev -y

# Install MS SQL Server client tools (https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-2017)
apt-get install -y mssql-tools unixodbc-dev
apt-get -f install
ln -s /opt/mssql-tools/bin/* /usr/local/bin/

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v mysql; then
    echo "mysql was not installed"
    exit 1
fi

set -e
mysql -vvv -e 'CREATE DATABASE smoke_test' -uroot -proot
mysql -vvv -e 'DROP DATABASE smoke_test' -uroot -proot
set +e

# Disable mysql.service
systemctl is-active --quiet mysql.service && systemctl stop mysql.service
systemctl disable mysql.service

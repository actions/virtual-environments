#!/bin/bash -e
################################################################################
##  File:  php.sh
##  Desc:  Installs php
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh
source $HELPER_SCRIPTS/os.sh

# add repository
apt-add-repository ppa:ondrej/php -y
apt-get update

# Install PHP
if isUbuntu16 ; then
    php_versions="5.6 7.0 7.1 7.2 7.3 7.4"
fi

if isUbuntu18 ; then
    php_versions="7.1 7.2 7.3 7.4"
fi

if isUbuntu20 ; then
    php_versions="7.4"
fi

for version in $php_versions; do
    echo "Installing PHP $version"
    apt-fast install -y --no-install-recommends \
        php$version \
        php$version-bcmath \
        php$version-bz2 \
        php$version-cgi \
        php$version-cli \
        php$version-common \
        php$version-curl \
        php$version-dba \
        php$version-dev \
        php$version-enchant \
        php$version-fpm \
        php$version-gd \
        php$version-gmp \
        php$version-imap \
        php$version-interbase \
        php$version-intl \
        php$version-json \
        php$version-ldap \
        php$version-mbstring \
        php$version-mysql \
        php$version-odbc \
        php$version-opcache \
        php$version-pgsql \
        php$version-phpdbg \
        php$version-pspell \
        php$version-readline \
        php$version-snmp \
        php$version-soap \
        php$version-sqlite3 \
        php$version-sybase \
        php$version-tidy \
        php$version-xml \
        php$version-xmlrpc \
        php$version-xsl \
        php$version-zip

    if [[ $version == "5.6" || $version == "7.0" || $version == "7.1" ]]; then
        apt-fast install -y --no-install-recommends php$version-mcrypt php$version-recode
        apt-get remove --purge -yq php$version-dev
    fi

    if [[ $version == "7.2" || $version == "7.3" ]]; then
        apt-fast install -y --no-install-recommends php$version-recode
    fi
done

apt-fast install -y --no-install-recommends \
    php-amqp \
    php-apcu \
    php-igbinary \
    php-memcache \
    php-memcached \
    php-mongodb \
    php-redis \
    php-xdebug \
    php-yaml \
    php-zmq

apt-get remove --purge -yq php7.2-dev

apt-fast install -y --no-install-recommends snmp

# Install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === file_get_contents('https://composer.github.io/installer.sig')) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
sudo mv composer.phar /usr/bin/composer
php -r "unlink('composer-setup.php');"

# Update /etc/environment
prependEtcEnvironmentPath /home/runner/.config/composer/vendor/bin

# Add composer bin folder to path
echo 'export PATH="$PATH:$HOME/.config/composer/vendor/bin"' >> /etc/skel/.bashrc

#Create composer folder for user to preserve folder permissions
mkdir -p /etc/skel/.composer

# Install phpunit (for PHP)
wget -q -O phpunit https://phar.phpunit.de/phpunit-7.phar
chmod +x phpunit
mv phpunit /usr/local/bin/phpunit

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in php $php_versions composer phpunit; do
    if [[ $cmd =~ ^[0-9] ]]; then
        cmd="php$cmd"
    fi

    if ! command -v $cmd; then
        echo "$cmd was not installed"
        exit 1
    fi
done

# ubuntu 20.04 libzip-dev is libzip5 based and is not compatible libzip-dev of ppa:ondrej/php
# see https://github.com/actions/virtual-environments/issues/1084
if isUbuntu20 ; then
  rm /etc/apt/sources.list.d/ondrej-ubuntu-php-focal.list
  apt-get update
fi

#! /bin/bash

echo 'POST-INSTALL: Executing Post-Installation Tasks (Say y to everything)'
echo 'POST-INSTALL: Loading Webtatic Repo'
sudo rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm
echo 'POST-INSTALL: Loading RPMForge Repo'
sudo rpm -Uvh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
echo 'POST-INSTALL: Installing Packages'
sudo yum install --enablerepo=webtatic-testing php56w php65w-pdo php56w-pear php56w-opcache php56w-common php56w-devel git htop gcc -y
echo 'POST-INSTALL: Downloading Composer'
sudo curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
echo 'POST-INSTALL: PECL Extensions'
yes '' | sudo pecl install mongo redis xdebug
sudo chkconfig httpd on
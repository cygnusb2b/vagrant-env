#! /bin/bash

ssh-keyscan -H cygnus.beanstalkapp.com >> ~/.ssh/known_hosts
ssh-keyscan -H github.com >> ~/.ssh/known_hosts

sites[0]='aviationpros'
sites[1]='cpapracticeadvisor'
sites[2]='emsworld'
sites[3]='firehouse'
sites[4]='foodlogistics'
sites[5]='forresidentialpros'
sites[6]='greenindustrypros'
sites[7]='locksmithledger'
sites[8]='masstransitmag'
sites[9]='myprintresource'
sites[10]='oemoffhighway'
sites[11]='officer'
sites[12]='sdcexec'
sites[13]='securityinfowatch'
sites[14]='vehicleservicepros'
sites[15]='vendingmarketwatch'

mkdir -p '/data/localsites/www/base/forconstructionpros'
cd '/data/localsites/www/base/forconstructionpros'
git clone git@cygnus.beanstalkapp.com:/cygnus/base-site-forconstructionpros.git .
php -d memory_limit=-1 /usr/local/bin/composer install --prefer-dist -vv --no-interaction
php app/console cache:clear
php app/console assetic:dump
php app/console doctrine:mongodb:schema:update
chmod -R 777 app/cache
chmod -R 777 app/logs
cd '..'

for f in "${sites[@]}"
do
	mkdir $f
	cd $f
	git clone git@cygnus.beanstalkapp.com:/cygnus/base-site-$f.git .
	ln -s ../forconstructionpros/vendor
	ln -s ../forconstructionpros/composer.lock
	php app/console cache:clear
	php app/console assetic:dump
	php app/console doctrine:mongodb:schema:update
	chmod -R 777 app/cache
	chmod -R 777 app/logs
	cd '..'
done
#!/usr/bin/env bash

echo "--- Good morning, master. Let's get to work. Installing now. ---"

echo "--- Updating packages list ---"
sudo apt-get update

echo "--- MySQL time ---"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

echo "-- Pgsql --"
sudo apt-get install -y postgresql postgresql-contrib

echo "--- Installing base packages ---"
sudo apt-get install -y vim curl python-software-properties

echo "--- Updating packages list ---"
sudo apt-get update

echo "--- We want the bleeding edge of PHP, right master? ---"
sudo add-apt-repository -y ppa:ondrej/php5

echo "--- Updating packages list ---"
sudo apt-get update

echo "--- Installing PHP-specific packages ---"
sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-dev php5-curl php5-gd php5-mcrypt mysql-server-5.5 php5-mysql php5-pgsql git-core

echo "--- Installing and configuring Postgres ---"
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/9.1/main/postgresql.conf
echo "host    all             all             0.0.0.0/0               md5" | sudo tee -a /etc/postgresql/9.1/main/pg_hba.conf
sudo service postgresql start
sudo -u postgres psql -c "CREATE ROLE root LOGIN UNENCRYPTED PASSWORD 'root' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"
sudo -u postgres /usr/bin/createdb --echo --owner=root vagrant
sudo service postgresql start

echo "--- Installing and configuring Xdebug ---"
sudo apt-get install -y php5-xdebug

cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

echo "--- Installing and configuring mailparse ---"
sudo pecl install mailparse
echo "extension=mailparse.so" | sudo tee -a /etc/php5/apache2/php.ini

echo "--- Enabling mod-rewrite ---"
sudo a2enmod rewrite
sudo cp /vagrant/vagrant/apache2.conf /etc/apache2/sites-available/000-default.conf

echo "--- Setting document root ---"
sudo rm -rf /var/www
sudo ln -fs /vagrant/public /var/www

echo "--- What developer codes without errors turned on? Not you, master. ---"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini

echo "--- Restarting Apache ---"
sudo service apache2 restart
sudo service postgresql restart

echo "--- Composer is the future. But you knew that, did you master? Nice job. ---"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Laravel stuff here, if you want
cd /vagrant
chmod -R o+w app/storage
# php artisan migrate --seed --env=local

echo "--- Cakes and Pies! ---"

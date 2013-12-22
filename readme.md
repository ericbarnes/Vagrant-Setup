My install Bash script for Vagrant.

This will install

* php5.5
* postgres
* mysql
* setup vhost
* composer
* php mailparse
* xdebug for phpstorm

See vagrant/install.sh to make changes to suit your needs.

## Postgres

DB connection through Postgres Navicat

* HostName: 127.0.0.1
* Port: 54320
* Default Database: vagrant
* Username: root
* Password: root

## MySQL

SSH DB connection through Sequel Pro

* Host: 127.0.0.1
* Username: root
* Password: root
* Port: 3306
* SSH Host: 127.0.0.1
* SSH User: vagrant
* SSH Password: ~/.vagrant.d/insecure_private_key
* SSH Port: 2220


## Thanks goes to the following references:

- [https://laracasts.com/lessons/vagrant-and-laravel](https://laracasts.com/lessons/vagrant-and-laravel)
- [https://gist.github.com/fideloper/7074502](https://gist.github.com/fideloper/7074502)
- [Setting Up Vagrant With Laravel 4](http://culttt.com/2013/06/17/setting-up-vagrant-with-laravel-4/)
- [How to Install the Latest Version of PHP 5.5 on Ubuntu](http://www.dev-metal.com/how-to-setup-latest-version-of-php-5-5-on-ubuntu-12-04-lts/)

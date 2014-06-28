#!bin/bash
#
#This bash script is to install applications


#Update ubuntu and download all the application needed for web development
echo -e '\033[33m----------Starting ubuntu update and programs installation----------\033[33m'
echo -e "\033[0m"
sudo apt-get update

sudo apt-get install mysql-server-5.5 php5 php5-mysql php5-gd apache2 phpmyadmin drush -y

sudo a2enmod rewrite

sudo a2enmod vhost_alias

sudo service apache2 restart



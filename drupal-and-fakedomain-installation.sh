#!/bin/bash
# Drupal Installation and Fake Domain Creation
#
# Created by Adrian Ravis 2013-10-22
# https://github.com/dreiren
#
# Edited by Japo Domingo 2013-11-05
# https://github.com/japo32

echo ''
echo -e '\033[33m#---------This will install Drupal in Home Directory---------#\033[33m#'

read -p 'Press [Enter] Key To Start'
    echo -e "\033[0m"
sleep 2

DEF_APACHE_SITES=/etc/apache2/sites-available

LOOP=true
while $LOOP; do
  read -p "Enter your Apache folder(default=$DEF_APACHE_SITES): " APACHE_SITES
  if [[ $APACHE_SITES == "" ]]; then
    APACHE_SITES=$DEF_APACHE_SITES
  fi
  if [[ -d $APACHE_SITES ]]; then
    LOOP=false
  else
    echo -e "\033[33m$APACHE_SITES is not a valid directory\033[33m"
    echo -e "\033[0m"
  fi
done

read -p "Enter your VHost filename( created in $APACHE_SITES ): " vhost

DEF_DIRECTORY=/home/$USER

LOOP=true
while $LOOP; do
  read -p "Where will your install folder be stored.(default=$DEF_DIRECTORY): " DIRECTORY
  if [[ $DIRECTORY == "" ]]; then
    DIRECTORY=$DEF_DIRECTORY
  fi
  if [[ -d $DIRECTORY ]]; then
    LOOP=false
  else
    echo -e "\033[33m$DIRECTORY is not a valid directory\033[33m"
    echo -e "\033[0m"
  fi
done

read -p "Enter the name of your install folder( created in $DIRECTORY ): " docroot
docroot=$DIRECTORY/$docroot

read -p "Enter your your Server Name( ex. dev.mysite.com ): " servername
read -p "Type host ( ex. 127.0.0.1 ): " host
read -p "Enter Drupal version: ( ex. 7.23 ): " dversion


echo 'This may take a while...Grab some gloves and punch some of your friends! XD'
sleep 4

#Download Drupal
echo "Downloading Drupal"
sudo wget http://ftp.drupal.org/files/projects/drupal-$dversion.tar.gz


#Create VHost file and setup Virtual Host
echo -e '\033[33m----------Virtual Hosts Setup ----------\033[33m'
echo -e "\033[0m"
echo "Creating $APACHE_SITES/$vhost"
sudo touch $APACHE_SITES/$vhost

echo "<Virtualhost *:80>
  ServerName $servername
  DocumentRoot $docroot
</Virtualhost>" | sudo tee $APACHE_SITES/$vhost
echo "Creating $docroot"
sudo mkdir $docroot
sleep 2

#Append the another virtual host to the hosts text file
echo "Adding $host $servername to /etc/hosts"
echo "$host $servername" | sudo tee -a /etc/hosts
sleep 2

#enable the virtual host
echo "Enabling VHost"
sudo a2ensite $vhost
sleep 2

#Extract drupal
echo -e '\033[33m----------Extracting drupal-7.23.tar.gz----------\033[33m'
echo -e "\033[0m"
sleep 2
sudo tar -zxvf drupal-$dversion.tar.gz

#Move drupal files to /var/www/auinp
echo -e '\033[33m----------Moving drupal files to fake domain folder----------\033[33m'
echo -e "\033[0m"
sleep 2
# added explicit inclusion for the hidden files
sudo cp -R  drupal-$dversion/* drupal-$dversion/.htaccess drupal-$dversion/.gitignore $docroot

#Creating a settings.php from default.settings.php
echo -e '\033[33m----------Settings.php and files folder ----------\033[33m'
echo -e "\033[0m"
sleep 2
sudo cp $docroot/sites/default/default.settings.php $docroot/sites/default/settings.php
sudo mkdir $docroot/sites/default/files
echo "Created files and settings.php"
sudo chmod uga+rwx $docroot/sites/default/settings.php
sudo chmod uga+rwx $docroot/sites/default/files
echo "Changed write permissions for files and settings.php"
echo "--> Remember to remove write permissions for settings.php after installation"


#Create database for druapal site
echo -e '\033[33m----------Create database for drupal site----------\033[33m'
echo -e "\033[0m"

read -p "Enter database Username: " uname
read -sp "Enter database password: " pass #-s used to hide the password input of the user
echo ""
read -p "Name of Database: " dbname
#Create database
mysqladmin -u$uname -p$pass create $dbname
echo "Created $dbname"



#Restarting the apache2
echo -e '\033[33m----------Restarting the Apache2----------\033[33m'
echo -e "\033[0m"
sudo service apache2 restart


#The End of the Installation
echo -e '\033[33m----------The End of the Drupal Installation----------\033[33m'
echo "----------You can now Install your Drupal in your browser--------"
echo "----------Please check $servername in your browser--------"
echo '----------Thank You!--------'
echo -e "\033[0m"

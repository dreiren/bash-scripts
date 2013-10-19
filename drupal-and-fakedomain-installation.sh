#!bin/bash
#Drupal Installation and Fake Domain Creation
echo ''
echo -e '\033[33m#---------This will install Drupal in Home Directory---------#\033[33m#'
sleep 2

read -p 'Press [Enter] Key To Start'
sleep 2

echo 'This may take a while...Grab a gloves and punch some of your friends! XD'
sleep 4

#Install drupal in home directory
echo '----------Installing Drupal----------'
echo '----------Supply Root Password---------'
echo -e "\33m[0m"
sudo wget http://ftp.drupal.org/files/projects/drupal-7.23.tar.gz

#Ceate Fake Domain
echo -e '\033[33m----------Create Fake Domain----------\033[33m'
echo -e "\033[0m"
sleep 2

#This will accept the inputed fake domain file name from the user
echo -e '\033[33m----------Please Enter your Fake Domain name----------\033[33m'
echo -e "\033[0m"
echo "Enter your Fake Domain Name( ex. myFakedomainName )" 
read dname
sudo touch /etc/apache2/sites-available/$dname

#Changing the Directory
echo -e '\033[33m----------Changing Directory----------\033[33m'
echo -e "\033[0m"
sleep 2
cd /etc/apache2/sites-available/


#This text will be inputed in the /etc/apache2/sites-available/auinp text file
echo -e '\033[33m----------Adding Text to the Text File----------\033[33m'
echo -e "\033[0m"
sleep 2

#This will accept the inputed fake domain file name from the user
echo "Enter your your Server Name(Ex. dev.fakedomain.com ): "
read servername
echo "Enter your your Document Root(Ex. /home/user/foldername ): "
read docroot

echo "<Virtualhost :*80>
	ServerName $servername
	DocumentRoot $docroot
	</Virtualhost>" | sudo tee $dname #in Exchange of > sudo auinp


#Adding the created faked domain to hosts
echo -e '\033[33m----------Add the Fake domain to hosts----------\033[33m'
echo -e "\033[0m"
sleep 2

#Changing directory to  /etc/
echo -e '\033[33m----------Change Directory to /etc/----------\033[33m'
echo -e "\033[0m"
sleep 2
cd /etc/

#Append the another fake domain to the hosts text file
echo -e '\033[33m----------Editing /etc/hosts----------\033[33m'
echo -e "\033[0m"
sleep 2
echo "127.0.1.1 $servername" | sudo tee -a hosts #in Exchange of >> sudo hosts to append this text


#enable the fake domain
echo -e '\033[33m----------Enabling the Fake domain----------\033[33m'
echo -e '\033[0m'
sleep 2
sudo a2ensite auinp

#Reloading apache2
echo -e '\033[33m----------Reloading apache2----------\033[33m'
echo -e "\033[0m"
sleep 2
sudo service apache2 reload

#Changing directory to home
echo -e '\033[33m----------Change Directory to /etc/----------\033[33m'
echo -e "\033[0m"
sleep 2
cd

#Extract drupal
echo -e '\033[33m----------Extracting drupal-7.23.tar.gz----------\033[33m'
echo -e "\033[0m"
sleep 2
sudo tar -zxvf ~/drupal-7.23.tar.gz

#Move drupal files to /var/www/auinp
echo -e '\033[33m----------Moving drupal files to fake domain folder----------\033[33m'
echo -e "\033[0m"
sleep 2
sudo cp -R  ~/drupal-7.23/  $docroot

#Creating folder "files" in /var/www/$docroot 
echo -e '\033[33m----------Creating folder "files" in $docroot/sites----------\033[33m'
echo -e "\033[0m"
sleep 2
sudo mkdir $docroot/sites/default/files

#Creating a settings.php from default.settings.php
echo -e '\033[33m----------Creating a settings.php ----------\033[33m'
echo -e "\033[0m"
sleep 2
sudo cp $docroot/sites/default/default.settings.php $docroot/sites/default/settings.php


#Set Permission as a+rwx to created files folder and settings.php
echo -e '\033[33m----------Set Permission to created files folder and settings.php ----------\033[33m'
echo -e "\033[0m"
sleep 2
sudo chmod uga+rwx $docroot/sites/default/settings.php && sudo chmod uga+rwx $docroot/sites/default/files


#Create database for druapal site
echo -e '\033[33m----------Create database for druapal site----------\033[33m'
echo -e "\033[0m"

echo "Enter database Username: "
read  uname
echo "Enter database password: "
read  -s pass #-s used to hide the password input of the user
echo "Name of Database: "
read  dbname
#Create database
mysqladmin -u$uname -p$pass create $dbname
echo -e '\033[33m----------Creating Database Successful----------\033[33m'
echo -e "\033[0m"



#Restarting the apache2
echo -e '\033[33m----------Restarting the Apache2----------\033[33m'
echo -e "\033[0m"
sudo service apache2 restart


#The End of the Installation
echo -e '\033[33m----------The End of the Drupal Installation----------\033[33m'
echo '----------You can now Install your Drupal in your browser--------'
echo '----------Thank You!--------'
echo -e "\033[0m"

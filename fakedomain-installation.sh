#!bin/bash
#This script install a new FAKE DOMAIN

echo ''
echo -e '\033[33m#---------This will install Drupal in Home Directory---------#\033[33m#'
sleep 2

read -p 'Press [Enter] Key To Start'
sleep 2

echo 'This may take a while...Grab a gloves and punch some of your friends! XD'
sleep 4


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
	</Virtualhost>" | sudo tee $dname #in Exchange of > sudo fake domain name
echo -e '\033[33m----------Adding Document Root folder----------\033[33m'
echo -e "\033[0m"
sleep 2
sudo mkdir $docroot

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
echo "Type host (Ex. 127.0.1.1): "
read host
echo "$host $servername" | sudo tee -a hosts #in Exchange of >> sudo hosts to append this text


#enable the fake domain
echo -e '\033[33m----------Enabling the Fake domain----------\033[33m'
echo -e '\033[0m'
sleep 2
sudo a2ensite $dname

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

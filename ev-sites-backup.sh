#!bin/bash
# EV Sites backup process
echo ''
echo -e '\033[33m#---------Preparing to backup EV website files---------#\033[33m#'
sleep 2

read -p 'Press [Enter] Key To Start'
sleep 2

# Get date today
datetoday=`date +%Y-%m-%d`

# Set a database connection from remote host for mysqldump
#----

#Copy files from EV site directory
#Need to change this

echo '----------Copying Remote EV site files to local pc----------'
echo -e "\33m[0m"
scp -vrCP 2222 planet6@eastvantage.com:public_html/\{profiles,scripts,sites,includes,themes,misc,modules,authorize.php,CHANGELOG.txt,COPYRIGHT.txt,cron.php,index.php,install.php,INSTALL.mysql.txt,INSTALL.pgsql.txt,INSTALL.sqlite.txt,INSTALL.txt,LICENSE.txt,MAINTAINERS.txt,README.txt,robots.txt,update.php,UPGRADE.txt,web.config,xmlrpc.php,.gitignore,.htaccess\} \
/media/sf_C_DRIVE/Users/Jovert/Documents/EV\ Websites\ Backup/ev/ev-$datetoday
echo '----------Compressing EV site files----------'
echo -e "\33m[0m"


#Copy files from EV meeting room tool directory
echo '----------Copying Remote EV meeting room tool files to local pc----------'
echo -e "\33m[0m"
scp -vrCP 2222 planet6@eastvantage.com:public_html/ev-meeting \
/media/sf_C_DRIVE/Users/Jovert/Documents/EV\ Websites\ Backup/evm/evm-$datetoday
echo '----------Compressing EV site files----------'
echo -e "\33m[0m"

#Copy files from bfbc directory
echo '----------Copying Remote bfbc files to local pc----------'
echo -e "\33m[0m"
scp -vrCP 2222 planet6@eastvantage.com:public_html/bfbc \
/media/sf_C_DRIVE/Users/Jovert/Documents/EV\ Websites\ Backup/bfbc/bfbc-$datetoday
echo '----------Compressing bfbc files----------'
echo -e "\33m[0m"

#The End of the Installation
echo -e '\033[33m----------The End of Backup----------\033[33m'
echo '----------Thank You!--------'
echo -e "\033[0m"

#!bin/bash
#Download all the standard modules in drupal
echo -e '\033[33m----------Downloading all the standard modules in drupal----------\033[33m'
echo -e "\033[0m"
echo -e '\033[33m----------Creating contrib folder inside module folder of drupal----------\033[33m'
echo -e "\033[0m"
echo "Enter your site Document Root: "
read docroot
sudo mkdir $docroot/sites/all/modules/contrib
cd $docroot/sites/all/modules/contrib
sudo drush dl admin admin_menu ckeditor ctools devel eva features feeds library module_filter pathauto token views views_slideshow jquery_update  -y
sudo drush en admin admin menu ckeditor ctools page_manager ctools_custom_content bulk_export views_content stylizer ctools_plugin_example ctools_ajax_sample ctools_access_ruleset
		devel devel_generate devel_node_access
		eva features feeds feeds_news feeds_ui feeds_import
		library module_filter pathauto token views views_ui views_slideshow views_slideshow_cycle -y
cd /var/www/auinp
sudo drush dis overlay toolbar -y
sudo drush cc all -y
#change directory to home
cd

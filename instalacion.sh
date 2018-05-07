#!/bin/bash

# Establecemos el cortafuegos
service iptables restart
iptables -F
iptables -A INPUT -p tcp -m multiport --dports 80,5901 -j ACCEPT
iptables -A INPUT -p tcp -m multiport --sports 80,53,443,9418 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT
iptables -A INPUT -j DROP
iptables -A FORWARD -j ACCEPT
iptables -A OUTPUT -j ACCEPT

pwd=$(pwd)
install_dir='/var/www/html/restaurante-ja'
virtuemart_zip='http://dev.virtuemart.net/attachments/download/1112/VirtueMart3.2.12_Joomla_3.8.3-Stable-Full_Package.zip'
rm -rf $install_dir
# Incluimos los repositorios necesarios
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

# Instalamos los paquetes del sistema
yum update -y
yum install -y httpd mysql-server mod_php71w php71w-opcache php71w-mysql

# Hacemos que los servicios arranquen con el sistema
chkconfig httpd on
chkconfig mysqld on

# Creamos la base de datos
service mysqld start
cat crear_bd.sql | mysql
cat db.sql | mysql -u r_ja r_ja --password='12345678'

# Instalamos Joomla
mkdir $install_dir
cd $install_dir
wget $virtuemart_zip -O virtuemart.zip
unzip virtuemart.zip
cp ${pwd}/configuration.php ${install_dir}/configuration.php
rm -rf ${install_dir}/installation
chown -R apache:apache *
service httpd start
wget localhost/restaurante-ja > /dev/null
firefox localhost/restaurante-ja &

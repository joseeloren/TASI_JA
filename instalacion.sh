#!/bin/bash
# Incluimos los repositorios necesarios
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

# Instalamos los paquetes del sistema
yum update
yum install httpd mysql-server mod_php71w php71w-opcache -y

# Hacemos que los servicios arranquen con el sistema
chkconfig httpd on
chkconfig mysqld on

# Arrancamos los servicios
service httpd start
service mysqld start

# Creamos la base de datos
cat crear_bd.sql | mysql

# Instalamos Joomla
cd /var/www/html
wget http://dev.virtuemart.net/attachments/download/1112/VirtueMart3.2.12_Joomla_3.8.3-Stable-Full_Package.zip 
unzip VirtueMart3.2.12_Joomla_3.8.3-Stable-Full_Package.zip


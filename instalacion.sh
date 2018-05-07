#!/bin/bash
pwd=$(pwd)
install_dir='/var/www/html/restaurante-ja2'
virtuemart_zip='http://dev.virtuemart.net/attachments/download/1112/VirtueMart3.2.12_Joomla_3.8.3-Stable-Full_Package.zip'
rm -rf $install_dir

opcion='l';
while true; do
    read -p "¿Quiere instalacion limpia (opcion l) o con la gestion de pedidos del restaurante montado (opcion m)? " lm
    case $lm in
	[Ll]* ) opcion='l'; break;;
	[Mm]* ) opcion='m'; break;;
	* ) echo "Elija una opcion valida" ;;
    esac
done
read -p "Indique el directorio del repositorio de Git (por ejemplo /home/foo/TASI_JA) " repo_dir
    
# Establecemos el cortafuegos
service iptables restart
iptables -F
iptables -A INPUT -p tcp -m multiport --dports 80,5901 -j ACCEPT
iptables -A INPUT -p tcp -m multiport --sports 80,53,443,9418 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT
iptables -A INPUT -j DROP
iptables -A FORWARD -j ACCEPT
iptables -A OUTPUT -j ACCEPT

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
cat $repo_dir/crear_bd.sql | mysql
case $opcion in
    l ) cat $repo_dir/db.sql | mysql -u r_ja2 r_ja2 --password='12345678';;
    m ) cat $repo_dir/db_final.sql | mysql -u r_ja2 r_ja2 --password='12345678';;
esac


# Instalamos Joomla
mkdir $install_dir
cd $install_dir
case $opcion in
    l ) wget $virtuemart_zip -O virtuemart.zip; unzip virtuemart.zip;cp $repo_dir/configuration.php ${install_dir}/configuration.php;rm -rf ${install_dir}/installation;;
    m ) unzip $repo_dir/restaurante-ja.zip -d .;;
esac
chown -R apache:apache *
service httpd start
wget localhost/restaurante-ja2 > /dev/null
firefox localhost/restaurante-ja2 &

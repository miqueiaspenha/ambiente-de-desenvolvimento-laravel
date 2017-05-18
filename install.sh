#!/bin/bash

echo "---- Iniciando instalacao do ambiente de Desenvolvimento PHP ---"

echo "--- Atualizando lista de pacotes ---"
sudo apt-get update

echo "--- Atualizando o sistema ---"
sudo apt-get upgrade --yes

# echo "--- Definindo Senha padrao para o MySQL e suas ferramentas ---"

# DEFAULTPASS="vagrant"
# sudo debconf-set-selections <<EOF
# mysql-server	mysql-server/root_password password $DEFAULTPASS
# mysql-server	mysql-server/root_password_again password $DEFAULTPASS
# dbconfig-common	dbconfig-common/mysql/app-pass password $DEFAULTPASS
# dbconfig-common	dbconfig-common/mysql/admin-pass password $DEFAULTPASS
# dbconfig-common	dbconfig-common/password-confirm password $DEFAULTPASS
# dbconfig-common	dbconfig-common/app-password-confirm password $DEFAULTPASS
# phpmyadmin		phpmyadmin/reconfigure-webserver multiselect apache2
# phpmyadmin		phpmyadmin/dbconfig-install boolean true
# phpmyadmin      phpmyadmin/app-password-confirm password $DEFAULTPASS
# phpmyadmin      phpmyadmin/mysql/admin-pass     password $DEFAULTPASS
# phpmyadmin      phpmyadmin/password-confirm     password $DEFAULTPASS
# phpmyadmin      phpmyadmin/setup-password       password $DEFAULTPASS
# phpmyadmin      phpmyadmin/mysql/app-pass       password $DEFAULTPASS
# EOF

echo "--- Instalando pacotes basicos ---"
sudo apt-get install --yes vim curl python-software-properties git-core

echo "--- Atualizando lista de pacotes ---"
sudo apt-get update --yes

# echo "--- Instalando MySQL, Phpmyadmin ---"
# sudo apt-get install --yes mysql-server mysql-client phpmyadmin

echo "--- Instalando PHP, Apache e alguns modulos ---"
sudo apt-get install --yes php apache2 libapache2-mod-php php-xml php-mbstring php-curl php-gd php-mcrypt php-zip unzip php-sqlite3 #php-mysql

echo "--- Habilitando mod-rewrite do Apache ---"
sudo a2enmod rewrite
sudo sed -i '164s/var\/www\/html/var\/www/g' /etc/apache2/apache2.conf
sudo sed -i '12s/var\/www\/html/var\/www/g' /etc/apache2/sites-available/000-default.conf
sudo sed -i '165s/Options Indexes FollowSymLinks/Options Indexes FollowSymLinks MultiViews/g' /etc/apache2/apache2.conf
sudo sed -i '166s/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf
sudo sed -i '5s/80/8080/g' /etc/apache2/ports.conf
sudo sed -i '1s/*:80/0.0.0.0:8080/g' /etc/apache2/sites-available/000-default.conf
sudo rm -R /var/www/html/

echo "--- Reiniciando Apache ---"
sudo service apache2 restart

echo "--- Baixando e Instalando Composer ---"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo "--- Baixando e instalando Laravel Instaler ---"
composer global require "laravel/installer"
echo 'export PATH="$PATH:$HOME/.config/composer/vendor/bin"' >> ~/.bashrc
source ~/.bashrc

echo "--- Instalando Banco NoSQL -> Redis <- ---"
sudo apt-get install --yes redis-server
sudo apt-get install --yes php-redis

echo "--- Reiniciando Apache ---"
sudo service apache2 restart

# Instale apartir daqui o que você desejar

echo "[OK] --- Ambiente de desenvolvimento concluido ---"

#! /bin/bash
# lancer le script en root ou avec un sudo
# Usage : bash mongodb-install.sh

FILE="/etc/apt/sources.list.d/mongodb.list"
CONFFILE="/etc/mongodb.conf"
DEFAULTLOGPATH="/var/log/mongodb/mongodb.log"
DEFAULTDBPATH="/var/lib/mongodb"

#FILE="./cout.txt"
CMD="deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen | sudo tee /etc/apt/sources.list.d/mongodb.list"

function install_mongodb
{
    sudo apt-get update
    sudo apt-get install mongodb-10gen
    echo "Installation de MongoDB terminé"
}

function restart_mongodb
{
    sudo service mongodb restart
}

function start_mongodb
{
    sudo service mongodb start
}

function stop_mongodb
{
    sudo service mongodb stop
}

#Recupere la clé GPG
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

if [ -f $FILE ] 
then
    while read line  
    do
	if [[ $line == *$CMD ]]
	then
	    echo "Le paquet a déjà été rajouté dans la liste des paquets"
	    break
	fi  
    done < $FILE
else
    sudo touch $FILE
    echo "" >> $FILE;
    echo "## Depot pour l'installation de mongoDB" >> $FILE;
    echo $CMD >> $FILE;
    echo "MongoDB a été rajouté dans la liste des paquets"
fi

install_mongodb
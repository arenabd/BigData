#! /bin/bash
# lancer le script en root ou avec un sudo
# Usage : bash webmin-install.sh

FILE="/etc/apt/sources.list"
#FILE="./cout.txt"
CMD="deb http://download.webmin.com/download/repository sarge contrib"

function install_webmin
{
    echo "" >> $FILE;
    echo "## Depot pour l'installation de webmin" >> $FILE;
    echo $CMD >> $FILE;
    sudo apt-get update
    echo "Webmin a été rajouté dans la liste des paquets"
    sudo apt-get install webmin
    echo "Installation de webmin terminé"
}

wget -O- http://www.webmin.com/jcameron-key.asc | sudo apt-key add -

if [ -f $FILE ] 
then
    while read line  
    do
	if [[ $line == *$CMD ]]
	then
	    echo "Le paquet a déjà été rajouté dans la liste des paquets"
	    exit
	fi  
    done < $FILE
    install_webmin
else  
    echo -n "ERREUR : Le fichier "
    echo -n $FILE
    echo " n'existe pas"
fi
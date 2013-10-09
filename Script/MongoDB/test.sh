#! /bin/bash
# lancer le script en root ou avec un sudo
#Script pour changer les chemins par défaut dans le dossier de conf mongodb

# Usage : bash mongodb-install.sh

FILE="/etc/apt/sources.list.d/mongodb.list"
CONFFILE="/etc/mongodb.conf"
DEFAULTLOGPATH="/var/log/mongodb/mongodb.log"
DEFAULTDBPATH="/var/lib/mongodb"

DBPATH="dbpath="

#echo $DBPATH$DEFAULTDBPATH
if [ -f $CONFFILE ]; then
    while read line  
    do
	if [[ $line == *$DBPATH$DEFAULTDBPATH ]]
	then
	    echo "le dbPath a été trouvé"
	fi
    done < $CONFFILE
else
echo "fin"
fi
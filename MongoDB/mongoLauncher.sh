if [ $# -eq 1 ]; then
    if [ $1 = "start" ]; then
	sudo mongod --fork -f /mongodb/conf/mongodbBase1.conf
	sudo mongod --fork -f /mongodb/conf/mongodbBase2.conf
	sudo mongod --fork -f /mongodb/conf/mongodbBase3.conf
	sudo mongod --fork -f /mongodb/conf/mongodbBase4.conf
    elif [ $1 = "stop" ]; then
	echo "###### shut down in progress... ######"
	sudo mongod -f /mongodb/conf/mongodbBase1.conf --shutdown;
	sudo mongod -f /mongodb/conf/mongodbBase2.conf --shutdown;
	sudo mongod -f /mongodb/conf/mongodbBase3.conf --shutdown;
	sudo mongod -f /mongodb/conf/mongodbBase4.conf --shutdown;
	echo "###### shut down done ######"
    elif [ $1 = "restart" ]; then
	echo "###### restart in progress... ######"
	sudo mongod -f /mongodb/conf/mongodbBase1.conf --shutdown;
	sudo mongod -f /mongodb/conf/mongodbBase2.conf --shutdown;
	sudo mongod -f /mongodb/conf/mongodbBase3.conf --shutdown;
	sudo mongod -f /mongodb/conf/mongodbBase4.conf --shutdown;
	sudo mongod --fork -f /mongodb/conf/mongodbBase1.conf
	sudo mongod --fork -f /mongodb/conf/mongodbBase2.conf
	sudo mongod --fork -f /mongodb/conf/mongodbBase3.conf
	sudo mongod --fork -f /mongodb/conf/mongodbBase4.conf
	echo "###### done ######"
    fi
else
    echo "Usage: launchMongo + [start|stop|restart]";
fi
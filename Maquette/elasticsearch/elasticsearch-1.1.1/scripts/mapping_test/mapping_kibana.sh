curl -XPUT 'localhost:9200/robot/'
echo""

curl -XPUT 'http://localhost:9200/webindex/' -d '{
    "index" : {
        "timestamp" : {
            "enabled" : true,
	    "index": "yes",
	    store: "yes"
        }
    }
}'
echo""
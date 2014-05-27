curl -XPUT 'localhost:9200/robot/'
echo""


curl -XPUT "localhost:9200/webindex/" -d '
{
"mappings" : {
    "_default_":{
        "_timestamp" : {
            "enabled" : true,
            "index" : true,
            "store" : true
        }
    }
  }
}'

echo ""
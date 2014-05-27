#!/bin/sh 

echo "Lancement du script de crawling"
DATE=$(date +%Y.%m.%d)
FILE="localhost:9200/webtest-$DATE"

echo "Mise à jour de l'index Robot"
echo ""
curl -XDELETE 'localhost:9200/robot/'
curl -XDELETE 'localhost:9200/_river/'
curl -XDELETE $FILE

curl -XPUT 'localhost:9200/robot/'
echo ""
curl -XPUT $FILE


echo ""
echo "Lancement du crawling..."
echo

curl -XPUT 'localhost:9200/_river/my_web/_meta' -d '{
    "type" : "web",
    "crawl" : {
	"index":"'webtest-$DATE'",
        "url" : ["http://www.journal-officiel.gouv.fr/"],
        "includeFilter" : ["http://www.journal-officiel.gouv.fr/.*"],
        "maxDepth" : 7,
        "maxAccessCount" : 10000,
        "numOfThread" : 5,
        "interval" : 3,
        "target" : [
          {
            "pattern" : {
              "url" : "http://www.journal-officiel.gouv.fr/balo/index.php/.*",
              "mimeType" : "text/html"
            },
           "properties" : {
                "title" : {
                    "text" : "title"
                },
                "body" : {
                    "text" : "body",
                    "trimSpaces" : true
                }
            }
          }
        ]
    },
    "schedule" : {
    "cron" : "1 * * * * ?"}}'

echo ""
echo "index : $FILE"
echo ""
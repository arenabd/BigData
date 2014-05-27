#!/bin/sh 

echo "Lancement du script de crawling"
DATE=$(date +%Y.%m.%d)
FILE="localhost:9200/webindex-$DATE"

echo "Mise à jour de l'index Robot"
echo ""
curl -XDELETE 'localhost:9200/robot/'

curl -XPUT 'localhost:9200/robot/'
echo ""
curl -XPUT $FILE


echo ""
echo "Lancement du crawling..."
echo

curl -XPUT 'localhost:9200/_river/my_web/_meta' -d '{
    "type" : "web",
    "crawl" : {
	"index":"'webindex-$DATE'",
        "url" : ["http://www.lemonde.fr/", "http://www.lepoint.fr/", "http://www.alcatel-lucent.fr/", "http://www.alstom.com/", "http://france.edf.com/"],
        "includeFilter" : ["http://www.lemonde.fr/.*", "http://www.lepoint.fr/.*", "http://www.alcatel-lucent.fr/.*", "http://www.alstom.com/.*", "http://france.edf.com/.*"],
        "maxDepth" : 3,
        "maxAccessCount" : 100,
        "numOfThread" : 5,
        "interval" : 1000,
        "target" : [
          {
            "pattern" : {
              "url" : "http://www.lemonde.fr/.*",
              "mimeType" : "text/html"
            },
            "properties" : {
              "title" : {
                "text" : "title"
              }
           }
          },
          {
            "pattern" : {
              "url" : "http://www.alcatel-lucent.fr/.*",
              "mimeType" : "text/html"
            },
            "properties" : {
              "title" : {
                "text" : "title"
              }
           }
          },
          {
            "pattern" : {
              "url" : "http://www.alstom.com/.*",
              "mimeType" : "text/html"
            },
            "properties" : {
              "title" : {
                "text" : "title"
              }
           }
          },
          {
            "pattern" : {
              "url" : "http://www.lepoint.fr/.*",
              "mimeType" : "text/html"
            },
            "properties" : {
              "title" : {
                "text" : "title"
              }
            }
          },
          {
            "pattern" : {
              "url" : "http://france.edf.com/.*",
              "mimeType" : "text/html"
            },
            "properties" : {
              "title" : {
                "text" : "title"
              }
            }
          }
        ]
    },
    "schedule" : {
    "cron" : "* 4 * * * ?"},

    "index" : {
        "analysis" : {
            "analyzer" : {
                "my_analyzer" : {
                    "tokenizer" : "standard",
                    "filter" : ["standard", "lowercase", "my_snow"]
                }
            },
            "filter" : {
                "my_snow" : {
                    "type" : "snowball",
                    "language" : "French"
                }
            }
        }
    }
}'

echo ""
HOUR=$(date +%Hh%M)

echo "InitCrawling.sh lancée le $DATE à $HOUR" >> /home/arenasi/Maquette/elasticsearch/elasticsearch-0.90.9/scripts/logs/script.log
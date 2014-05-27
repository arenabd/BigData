curl -XPUT 'localhost:9200/_river/my_web/_meta' -d '{
    "type" : "web",
    "crawl" : {
        "index" : "webindex",
        "url" : ["http://www.lemonde.fr/", "http://www.lepoint.fr/"],
        "includeFilter" : ["http://www.lemonde.fr/.*", "http://www.lepoint.fr/.*"],
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
              "url" : "http://www.lepoint.fr/.*",
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
        "cron" : "1 * * * * ?"
    }
}'

echo ""
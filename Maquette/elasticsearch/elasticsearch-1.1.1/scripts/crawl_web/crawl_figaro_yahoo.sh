curl -XPUT 'localhost:9200/_river/infos/_meta' -d '{
    "type" : "infos",
    "crawl" : {
        "index" : "webindex",
        "url" : ["http://www.lepoint.fr/"],
        "includeFilter" : ["http://www.lepoint.fr/.*"],
        "maxDepth" : 3,
        "maxAccessCount" : 100,
        "numOfThread" : 5,
        "interval" : 1000,
        "target" : [
          {
            "pattern" : {
              "url" : "http://www.lepoint.fr/.*",
              "mimeType" : "text/html"
            },
            "properties" : {
              "title" : {
                "text" : "title"
              },
              "body" : {
                "text" : "body"
              },
              "bodyAsHtml" : {
                "html" : "body"
              },
              "projects" : {
                "text" : "ul.nav-list li a",
                "isArray" : true
              }
            }
        ]
    },
    "schedule" : {
        "cron" : "1 * * * * ?"
    }
}'

echo ""
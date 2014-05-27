curl -XPUT "localhost:9200/webindex/infos/_mapping" -d '
{
  "infos" : {
    "dynamic_templates" : [
      {
        "url" : {
          "match" : "url",
          "mapping" : {
            "type" : "string",
            "store" : "yes",
            "index" : "not_analyzed"
          }
        }
      },
      {
        "method" : {
          "match" : "method",
          "mapping" : {
            "type" : "string",
            "store" : "yes",
            "index" : "not_analyzed"
          }
        }
      },
      {
        "charSet" : {
          "match" : "charSet",
          "mapping" : {
            "type" : "string",
            "store" : "yes",
            "index" : "not_analyzed"
          }
        }
      },
      {
        "mimeType" : {
          "match" : "mimeType",
          "mapping" : {
            "type" : "string",
            "store" : "yes",
            "index" : "not_analyzed"
          }
        }
      }
    ]
  }
}'

echo ""
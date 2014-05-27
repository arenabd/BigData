curl -XPOST 'localhost:9200/test-2014.03.24' -d '{
    "mappings" : {
        "BALO" : {
            "properties" : {
                @timestamp: {format: "dateOptionalTime", type: "date"}
            }
        }
    }
}'

echo ""
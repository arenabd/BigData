curl -XPUT localhost:9200/_river/mobiles/_meta -d '
{
    "type" : "twitter",
    "twitter" : {
        "oauth" : {
            "consumer_key" : "g7MosTsWxTFGBNBW2talMEAUw",
            "consumer_secret" : "jrlcYKCOBWvCLJjK0I31KNHagabv2oxHy1LSnJg8rQyziv2KPa",
            "access_token" : "1385220572-iKSrfWSSms5IRiJMw0ZjZMHHk1WCqITqIDXPqlk",
            "access_token_secret" : "DVndblFXUYhoFUjr8Rv4TulKIoV1BrUlEQgMplc8IzZLt"
        },
        "filter" : {
            "tracks" : "iphone,android,blackberry"
        } 
    },
    "index" : {
        "index" : "mobiles2",
        "type" : "tweet",
        "bulk_size" : 500
    }
}
'

curl -XPUT localhost:9200/_river/SEPA/_meta -d '
{
    "type" : "twitter",
    "twitter" : {
        "oauth" : {
            "consumer_key" : "g7MosTsWxTFGBNBW2talMEAUw",
            "consumer_secret" : "jrlcYKCOBWvCLJjK0I31KNHagabv2oxHy1LSnJg8rQyziv2KPa",
            "access_token" : "1385220572-iKSrfWSSms5IRiJMw0ZjZMHHk1WCqITqIDXPqlk",
            "access_token_secret" : "DVndblFXUYhoFUjr8Rv4TulKIoV1BrUlEQgMplc8IzZLt"
        },
        "filter" : {
            "tracks" : "#SEPA"
        } 
    },
    "index" : {
        "index" : "sepa",
        "type" : "tweet",
        "bulk_size" : 500
    }
}
'

echo "\nEnd of script"
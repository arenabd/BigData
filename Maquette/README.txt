**************************************************************************
*                                                                        *
*                                  ELASTICSEARCH                         *
*                                                                        *
*                                                                        *
**************************************************************************

Node ElasticSearch:


node1:

http://195.154.168.76:9200

elasticsearch-head:

http://195.154.168.76:9200/_plugin/head/

shutdown via rest API:

curl -XPOST http://localhost:9200/_cluster/nodes/_shutdown

**************************************************************************
*                                                                        *
*                                                                        *
*                                  LOGSTASH                              *
*                                                                        *
*                                                                        *
**************************************************************************

doc getting started : http://logstash.net/docs/1.3.2/tutorials/getting-started-simple

demarer logstash :

java -jar PATH_TO_LOGSTASH_JAR/logstash-1.3.2-flatjar.jar agent -f PATH_TO_LOGSTASH_CONF/logstash_complex.conf

Activer kibana embarqué avec logstash :

java -Xmx128M -jar PATH_TO_LOGSTASH_JAR/logstash-1.3.2-flatjar.jar agent -f PATH_TO_LOGSTASH_CONF/logstash_arena.conf -- web

curl -XPOST 'localhost:9200/test-2014.03.25/BALO/1234' -d '{
"message" : "je retest encore lalala",
"Societe" : "Alstom",
"N° daffaire" : 12345678,
"Paru le " : "2014.03.18",
"Annonce" : "Lien de lannonce",
"@timestamp" : "2014-03-19T13:17:33.000Z"
}'

echo ""
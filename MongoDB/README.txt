Utilisation de mongo import :
mongoimport -d mydb -c things --type csv --file locations.csv --headerline

Exemple de commande de test:

db.collection.find( {Ville: {$gt: 9}}, {_id: 0})

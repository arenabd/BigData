BigData
=======

Mettre en place une architecture distribué avec le framework java hadoop.







MONGODB

=======

start service : sudo service mongodb start
stop service : sudo service mongodb stop
connect to mongo shell : mongo

requetes sample:

insert = db.inventory.insert( { _id: 10, type: "misc", item: "card", qty: 15 } )

update = db.inventory.update(
                     { type: "book", item : "journal" },
                     { $set : { qty: 10 } },
                     { upsert : true }
                   )

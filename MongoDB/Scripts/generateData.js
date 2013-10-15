// Function takes three parameters : a db, a new or existing collection and the number
// of documents to create. The function creates documents with an x field that is set to
// an incremented integer, as in the following example documents:
// ex : insertData("test", "testData", 400)

function insertData(dbName, colName, num)
{
    var col = db.getSiblingDB(dbName).getCollection(colName);

    for (i = 0; i < num; i++)
    {
	col.insert({x:i});
    }
    print(col.count());
}
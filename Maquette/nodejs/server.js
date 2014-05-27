var http = require('http');
var server = http.createServer(function(req, res) {
    res.writeHead(200);
    res.end('Bonjour tout le monde');
});

server.on('close', function(){
    console.log('Bye bye !');
});

server.on('close', function() {
    console.log('Re bye bro !');
});

server.listen(8080);

server.close();
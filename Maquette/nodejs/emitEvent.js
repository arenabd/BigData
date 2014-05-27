var EventEmitter = require('events').EventEmitter;
var jeu = new EventEmitter();


jeu.on('gameover', function(message, age){
    console.log(message + " et tu as " + age + " ans");
});


jeu.emit('gameover', 'Vous avez perdu', 34);
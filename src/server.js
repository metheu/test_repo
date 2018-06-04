const express = require('express');
const bodyParser = require('body-parser');
const MongoClient = require('mongodb').MongoClient;
const app = express();

var db;
var path = require('path');

MongoClient.connect('mongodb://admin:admin@ds137600.mlab.com:37600/starwars-quotes', function(err, client){
    //..start the server
    if (err) {
        return console.log(err);
    };

    db = client.db('starwars-quotes');
    app.use(bodyParser.urlencoded({extended: true}));
    app.set('view engine', 'ejs');
    app.set('views', path.join(__dirname, 'views'));
    console.log((path.join(__dirname, 'views')));

// start server
app.listen(3000, function(){
    app.get('/', function(req, res){
       // res.sendFile(__dirname + '/html/index.html');

        db.collection('quotes').find().toArray(function (err, results){
            if(err){
                return console.log(err);
            }  
                // render index.ejs
                res.render('index.ejs', {quotes:results});
        });
    });

    // app.get('/quotes', function(req, res){
    //     // res.sendFile(__dirname + '/html/index.html');
 
    //      db.collection('quotes').find().toArray(function (err, results){
    //          if(err){
    //              return console.log(err);
    //          }  
    //              // render index.ejs
    //              res.render('index.ejs', {quotes:results});
    //      });
    //  });
    

    app.post('/quotes', function(req, res){
        db.collection('quotes').save(req.body, function(err, result){
            if(err){
                return console.log(err);
            }

            console.log('saved to db');

            res.redirect('/');
        })
    });
});

});


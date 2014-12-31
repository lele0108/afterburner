// BASE SETUP
// =============================================================================

// call the packages we need
var express    = require('express');
var bodyParser = require('body-parser');
var app        = express();
var morgan     = require('morgan');

// configure app
app.use(morgan('dev')); // log requests to the console

// configure body parser
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var port     = process.env.PORT || 8080; // set our port

var mongoose   = require('mongoose');
mongoose.connect('mongodb://afterburner:password@dogen.mongohq.com:10097/afterburner'); // connect to our database
var Card     = require('./app/models/card');

// ROUTES FOR OUR API
// =============================================================================

// create our router
var router = express.Router();

// middleware to use for all requests
router.use(function(req, res, next) {
	// do logging
	console.log('Something is happening.');
	next();
});

// test route to make sure everything is working (accessed at GET http://localhost:8080/api)
router.get('/', function(req, res) {
	res.json({ message: 'hooray! welcome to our api!' });	
});

// on routes that end in /bears
// ----------------------------------------------------
router.route('/card')

	// create a bear (accessed at POST http://localhost:8080/bears)
	.post(function(req, res) {
		
		var card = new Card();		// create a new instance of the Bear model
		card.from = req.body.from;  // set the bears name (comes from the request)
		card.to = req.body.to;
		card.text = req.body.text;
		card.photoURL = req.body.photoURL;
		card.senderEmail = req.body.senderEmail;
		card.userEmail = req.body.userEmail;

		
		card.save(function(err) {
			if (err)
				res.send(err);

			res.json({ message: 'Card created!' });
		});

		
	})

// on routes that end in /bears/:bear_id
// ----------------------------------------------------
router.route('/card/:cardID')

	// get the bear with that id
	.get(function(req, res) {
		Card.findById(req.params.card_id, function(err, card) {
			if (err)
				res.send(err);
			res.json(card);
		});
	})


// REGISTER OUR ROUTES -------------------------------
app.use('/api', router);

// START THE SERVER
// =============================================================================
app.listen(port);
console.log('Magic happens on port ' + port);

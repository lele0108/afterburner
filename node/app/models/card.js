var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;

var CardSchema   = new Schema({
	from: String,
	to: String,
	text: String,
	photoURL: String,
	senderEmail: String,
	userEmail: String
});

module.exports = mongoose.model('Card', BearSchema);
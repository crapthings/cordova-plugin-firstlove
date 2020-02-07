var exec = require('cordova/exec');

var PLUGIN_NAME = "firstlove"; // This is just for code completion uses.

var firstlove = function() {}; // This just makes it easier for us to export all of the functions at once.
// All of your plugin functions go below this.
// Note: We are not passing any options in the [] block for this, so make sure you include the empty [] block.
firstlove.yeah = function(onSuccess, onError) {
  exec(onSuccess, onError, PLUGIN_NAME, 'yeah', []);
};
module.exports = firstlove;

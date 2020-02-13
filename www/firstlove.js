var exec = require('cordova/exec')

var PLUGIN_NAME = 'firstlove'

var firstlove = function() {}

firstlove.onFiles = function(onSuccess, onError) {
  exec(onSuccess, onError, PLUGIN_NAME, 'onFiles', [])
}

module.exports = firstlove

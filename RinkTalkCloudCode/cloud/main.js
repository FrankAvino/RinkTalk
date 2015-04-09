
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});


Parse.Cloud.afterSave("Event", function(request) {


	console.log("Saved event.");

  // send out notification to everyone inside that game that an event was recorded

});


Parse.Cloud.define("validateEvent", function(request, response) {
  // go through each event recorded for the game, consolidate and validate events
});
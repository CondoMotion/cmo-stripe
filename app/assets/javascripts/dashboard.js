// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
//= require handlebars
//= require ember
//= require ember-data
//= require_self
//= require cmo_stripe
//= require_tree ./controllers
//= require_tree ./helpers
//= require_tree ./models
//= require_tree ./routes
//= require_tree ./views

// for more details see: http://emberjs.com/guides/application/
CmoStripe = Ember.Application.create();

// $ ->
//         $.get('/issues.json', data:"", (response) ->
//                 issues = response
//                 $('#contents').html('<b>ISSUE</b>: ' + issues[0].title)
//         )


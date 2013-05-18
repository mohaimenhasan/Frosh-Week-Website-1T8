//= require jquery
//= require jquery_ujs
//= require handlebars
//= require ember
//= require ember-data
//= require_self
//= require skule_orientation
App = Ember.Application.create();
try { Typekit.load(); }
catch(e) {}
//= require_tree .

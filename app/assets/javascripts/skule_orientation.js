//= require_self
//= require ./store
//= require_tree ./models
//= require ./router
//= require_tree ./routes
//= require_tree ./controllers
//= require_tree ./views
//= require_tree ./helpers
//= require_tree ./templates

Ember.EasyForm.Config.registerWrapper('orientation', {
  formClass: '',
  fieldErrorClass: 'error',
  inputClass: 'input',
  hintClass: 'hint',
  labelClass: 'label',
  wrapControls: false,
  controlsWrapperClass: ''
});

Ember.EasyForm.Config.registerInputType('checkbox', Ember.EasyForm.Checkbox);

Ember.Handlebars.registerBoundHelper('timestamp', function(date, options) {
  var formatter = options.hash.format ? options.hash.format : 'hh:mm a MM-DD-YYYY';
  var parsed = moment(date);
  var formatted = parsed.format(formatter);

  return new Ember.String.htmlSafe(formatted);
});

Ember.Handlebars.registerBoundHelper('pluralize', function(count, options) {
  var singular = options.hash.string;
  var plural = options.hash.plural || singular + 's';
  return count === 1 ? singular : plural;
});

Ember.Router.reopen({
  transitionTo: function() {
    this._super.apply(this, arguments);
    window.scrollTo(0, 1);
  },

  replaceWith: function() {
    this._super.apply(this, arguments);
    window.scrollTo(0, 1);
  }
});

App = Ember.Application.create();

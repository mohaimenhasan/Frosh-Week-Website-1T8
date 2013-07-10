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

App = Ember.Application.create();

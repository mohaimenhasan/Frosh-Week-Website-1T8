Ember.Handlebars.registerHelper('ifOnlinePurchase', function(options) {
  var end = new Date('Sept 04 2018 23:59:59 EDT');
  var current = new Date();
  if(current < end){
    return options.fn(this);
  }
  else {
    return options.inverse(this);
  }
});


Ember.Handlebars.registerHelper('ifAddonTitle', function(key, options) {

  var _key = Em.get(this, key);
  if(_key == "farm") {
      return options.fn(this);
  }
  else {
      return options.inverse(this);
  }
});

Ember.Handlebars.registerHelper('ifSoldOut', function(left, options) {

  var _left = Em.get(this, left);
  if(_left <= 0) {
      return options.fn(this);
  }
  else {
      return options.inverse(this);
  }
});



Ember.Handlebars.registerHelper('ifAddons', function(key, options) {

  var _key = Em.get(this, key);
  if(_key == "farm" || _key == "commuter") {
      return options.fn(this);
  }
  else {
      return options.inverse(this);
  }


});

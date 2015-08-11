
Ember.Handlebars.registerHelper('ifBeforeDeadline', function(key, options) {
  var leedurEnd = new Date('Aug 13 2015 23:59:59 EDT');
  var fweekEnd = new Date('Aug 31 2015 23:59:59 EDT');
  var current = new Date();
  var _key = Em.get(this, key);
  if(current < leedurEnd && _key == "leedur"){
    return options.fn(this);
  }
  else if(current < fweekEnd && _key == "fweek"){
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

Ember.Handlebars.registerHelper('ifLeedur', function(key, left, options) {
  
  var _left = Em.get(this, left);
  var _key = Em.get(this, key);
  if(_key == "leedur" && _left > 0) {
      return options.fn(this);
  }
  else {
      return options.inverse(this);
  }
});


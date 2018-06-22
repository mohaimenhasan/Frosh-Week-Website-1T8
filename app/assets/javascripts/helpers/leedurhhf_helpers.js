
Ember.Handlebars.registerHelper('ifBeforeDeadline', function(key, options) {
  var leedurEnd = new Date('July 22 2018 23:59:59 EDT');
  var fweekEnd = new Date('Aug 18 2018 23:59:59 EDT');
  var shirtEnd = new Date('Aug 18 2018 23:59:59 EDT');
  var current = new Date();
  var _key = Em.get(this, key);
  if(current < shirtEnd && _key == "leedur shirt"){
    return options.fn(this);
  }
  else if(current < leedurEnd && _key == "leedur"){
    return options.fn(this);
  }
  else if(current < leedurEnd && _key == "leedurnobus"){
      return options.fn(this);
  }
  else if(current < fweekEnd && _key == "fweek"){
    return options.fn(this);
  }
  else if(current < shirtEnd && _key == "shirt"){
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
  if(_key === 'leedur' && _left > 0) {
      return options.fn(this);
  }
  else {
      return options.inverse(this);
  }
});

Ember.Handlebars.registerHelper('ifLeedurNoBus', function(key, left, options){
    var _left = Em.get(this, left);
    var _key = Em.get(this, key);
    if(_key === 'leedurnobus' && _left > 0){
        return options.fn(this);
    }
    else {
        return options.inverse(this);
    }
})

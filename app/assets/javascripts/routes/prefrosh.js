App.PrefroshIndex = Ember.Route.extend({
  model: function() {
    return App.Admin.find('prefrosh');
  }
});

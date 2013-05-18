App.RegisterRoute = Ember.Route.extend({
  model: function() {
    return App.StoreItem.find();
  }
});

App.PreforshRoute = Ember.Route.extend({
  model: function() {
    return App.Prefrosh.find();
  }
});

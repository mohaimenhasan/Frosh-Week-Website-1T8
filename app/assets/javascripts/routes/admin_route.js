App.AdminRoute = Ember.Route.extend({
  model: function() {
    return App.Admin.find();
  }
});

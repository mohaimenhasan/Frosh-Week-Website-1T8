App.LeedurhhfIndexRoute = Ember.Route.extend({
    
  model: function() {
    return App.HhfPackage.find();
  }
});

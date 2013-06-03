App.PackagesIndexRoute = Ember.Route.extend({
  model: function() {
    return App.Package.find();
  }
});

App.PackagesItemRoute = Ember.Route.extend({
  model: function(params) {
    return App.Package.find({ name: params.item_name });
  },
  serialize: function(model) {
    return { item_name: model.get('name') };
  }
});

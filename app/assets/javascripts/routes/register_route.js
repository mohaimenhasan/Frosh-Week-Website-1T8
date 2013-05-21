App.RegisterIndexRoute = Ember.Route.extend({
  model: function() {
    return App.StoreItem.find();
  }
});

App.RegisterItemRoute = Ember.Route.extend({
  model: function(params) {
    return App.StoreItem.find({ name: params.item_name });
  },
  serialize: function(model) {
    return { item_name: model.get('name') };
  }
});

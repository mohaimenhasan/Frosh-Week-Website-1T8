App.PackagesIndexRoute = Ember.Route.extend({
  model: function() {
    return App.Package.find();
  }
});

App.PackagesItemRoute = Ember.Route.extend({
  model: function(params) {
    return App.Package.find({ name: params.name });
  },

  setupController: function(controller, model) {
    // Due to the model being returned from the server as an array,
    // and since returning a .get on the array element doesn't get
    // watched, we must use the following hack.
    // TODO(johnliu): fix this hack.
    var hack = model;
    if (model.get('content')) {
      hack = model.get('firstObject');
    }
    controller.set('model', hack);
  },

  serialize: function(model) {
    return { name: model.get('name') };
  }
});

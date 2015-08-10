App.RegistrationIndexRoute = Ember.Route.extend({
  //Call from index template and invoke def index in packages.rb
  model: function() {
    return App.PackageItem.find();
  }
});

App.RegistrationItemRoute = Ember.Route.extend({
  //Call from index template and invoke def index in packages.rb with specific params
  model: function(params) {
    return App.Package.find({ 'key': params.key });
  },

  renderTemplate: function(controller, model) {
    if (controller.get('model')) {
      this._super(controller, model);
    }
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

    if (!hack || hack.get("key").indexOf("early-bird") > -1) {
      this.transitionTo('registration.index');
    }
    controller.set('model', hack);
  },

  serialize: function(model) {
    //Check for model that exists in db otherwise, setupController will transition back
    if(model.get('content').get('firstObject')){
      return { 'key': model.get('firstObject').get('key') };
    }
    else {
      return { 'key': ""};
    }
    
  }
});

App.RegistrationReceiptRoute = Ember.Route.extend({
  renderTemplate: function(controller, model) {
    if (controller.get('model')) {
      this._super(controller, model);
    }
  },

  setupController: function(controller, model) {
    controller.notifyPropertyChange('model');
  }
});

App.RegistrationBursaryRoute = Ember.Route.extend({
  renderTemplate: function(controller, model) {
    if (controller.get('model')) {
      this._super(controller, model);
    }
  },

  setupController: function(controller, model) {
    controller.notifyPropertyChange('model');
  }
});

App.RegistrationConfirmRoute = Ember.Route.extend({
  model: function(params) {
    return App.User.find({ 'id': params.user, 'confirmation_token': params.token });
  },

  setupController: function(controller, model) {
    // Call for frosh groups to cache them earlier.
    App.Group.find();

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
    return { 'id': model.get('id'), 'token': model.get('confirmationToken') };
  }
});

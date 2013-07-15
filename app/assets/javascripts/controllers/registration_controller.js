App.RegistrationItemController = Ember.Controller.extend({
  cancel: function() {
    this.transitionToRoute('registration.index');
  }
});

App.RegistrationReceiptController = Ember.Controller.extend({
  selectedPackage: function() {
    var packageId = this.get('model.packageId');
    return App.Package.find(packageId);
  }.property('model.packageId'),

  init: function() {
    var that = this;
    this.addObserver('model', function() {
      if (!this.get('model')) {
        that.transitionToRoute('registration.index');
      }
    });
  },

  print: function() {
    window.print();
  }
});

App.RegistrationBursaryController = Ember.Controller.extend({
  init: function() {
    var that = this;
    this.addObserver('model', function() {
      if (!this.get('model')) {
        that.transitionToRoute('registration.index');
      }
    });
  }
});

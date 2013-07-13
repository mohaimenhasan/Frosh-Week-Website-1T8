App.RegistrationItemController = Ember.Controller.extend({
  cancel: function() {
    this.transitionToRoute('registration.index');
  }
});

App.RegistrationReceiptController = Ember.Controller.extend({
  ccData: null,
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

    this.addObserver('model.ccToken', function() {
      var token = that.get('model.ccToken');
      if (token) {
        Stripe.getToken(token, function(status, response) {
          if (status === 200) {
            that.set('ccData', response.card);
          }
        });
      }
    });
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

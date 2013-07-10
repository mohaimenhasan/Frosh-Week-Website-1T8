App.RegistrationItemController = Ember.Controller.extend({
  cancel: function() {
    this.transitionToRoute('registration.index');
  }
});

App.RegistrationReceiptController = Ember.Controller.extend({
  init: function() {
    var that = this;
    this.addObserver('model', function() {
      if (!this.get('model')) {
//        that.transitionToRoute('registration.index');
      }
    });
  }
});

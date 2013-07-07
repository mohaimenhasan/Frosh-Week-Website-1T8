App.PackagesItemController = Ember.Controller.extend({
  cancel: function() {
    this.transitionToRoute('packages.index');
  }
});

App.PackagesReceiptController = Ember.Controller.extend({
  init: function() {
    var that = this;
    this.addObserver('model', function() {
      if (!this.get('model')) {
//        that.transitionToRoute('packages.index');
      }
    });
  }
});

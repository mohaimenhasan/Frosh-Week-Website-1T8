App.PackagesItemController = Ember.Controller.extend({
  cancel: function() {
    this.transitionToRoute('packages.index');
  }
});

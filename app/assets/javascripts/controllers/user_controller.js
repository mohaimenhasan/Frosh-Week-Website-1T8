App.UserController = Ember.ObjectController.extend({
  needs: ['packagesItem'],

  init: function() {
    this._super();
    this.set('content', App.User.createRecord({}));
  },

  submit: function() {
    // TODO(johnliu): Validations for models
    var selected = this.get('controllers.packagesItem').get('model');
    console.log(selected.get('name'));
    console.log(this.get('content'));
    // this.get('store').commit();
  }
});

App.UserController = Ember.ObjectController.extend({
  needs: ['packagesItem'],

  init: function() {
    this._super();
    this.set('content', App.UserRaw.createRecord({}));
  },

  submit: function() {
    // TODO(johnliu): Validations for models
    var selected = this.get('controllers.packagesItem').get('model');
    console.log(selected.get('name'));
    var content = this.get('content');
    console.log(content);
    console.log(content.get('firstName'));
    content.validate().then(function() {
      console.log(content.get('isValid'));
    });
    // this.get('store').commit();
  }
});

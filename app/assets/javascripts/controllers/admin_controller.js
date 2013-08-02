App.AdminController = Ember.Controller.extend({
  users: null,

  init: function() {
    this._super.apply(this, arguments);
    this.set('users', App.User.find());
  },

  isLoggedIn: function() {
    return Ember.isNone(this.get('model'));
  }.property('model')
});

App.AdminUsersController = Ember.Controller.extend({
  needs: ['admin'],

  users: function() {
    return this.get('controllers.admin.users');
  }.property('controllers.admin.users'),

  filter: function(text) {
    console.log(text);
  }
});

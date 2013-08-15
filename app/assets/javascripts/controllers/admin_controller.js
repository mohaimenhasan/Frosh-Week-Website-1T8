App.AdminController = Ember.Controller.extend({
  users: [],

  init: function() {
    this._super.apply(this, arguments);
    this.set('users', App.User.find());

    var that = this;
    window.setTimeout(function() {
      if (Ember.isNone(that.get('model.firstObject'))) {
        var url = [];
        url.push(
          'https://accounts.google.com/o/oauth2/auth',
          '?response_type=code',
          '&client_id=',
          window._authCid,
          '&redirect_uri=',
          window._authRedir.indexOf('localhost') >= 0 ? 'http://' : 'https://',
          window._authRedir,
          '/auth',
          '&scope=https://www.googleapis.com/auth/userinfo.email'
        );
        url = url.join('');
        window.location = url;
      }
    }, 3000);
  },

  isLoggedIn: function() {
    return !Ember.isNone(this.get('model.firstObject'));
  }.property('model.firstObject')
});

App.AdminSubController = Ember.Controller.extend({
  needs: ['admin'],

  users: function() {
    return this.get('controllers.admin.users');
  }.property('controllers.admin.users'),

  isLoading: function() {
    return Ember.isNone(this.get('users.firstObject'));
  }.property('users.firstObject')
});

App.AdminIndexController = App.AdminSubController.extend({
  today: function() {
    return new Date();
  }.property(),

  registrationsToday: function() {
    var all = this.get('users');
    return all.filter(function(item) {
      var creation = item.get('createdAt');
      var today = this.get('today');

      return today.getFullYear() === creation.getFullYear() &&
        today.getMonth() === creation.getMonth() &&
        today.getDate() === creation.getDate();
    }, this).length;
  }.property('users.firstObject')
});

App.AdminUsersController = App.AdminSubController.extend({
  filteredUsers: function() {
    var all = this.get('users');
    var filtered = all.filter(function(item) {
      var query = this.get('query') || null;
      var values = [];

      // Combine all the values
      App.User.attributes.forEach(function(attribute) {
        var value = item.get(attribute) || '';
        values.push(value);
      }, this);
      values = values.join(' ');

      return values.match(new RegExp(query)) || query === null;
    }, this);

    return filtered;
  }.property('users.firstObject', 'query'),

  filter: function(text) {
    this.set('query', text);
  }
});

App.AdminUsersBursaryController = App.AdminSubController.extend({
  filteredUsers: function() {
    var all = this.get('users');
    var filtered = all.filter(function(item) {
      return item.get('bursaryRequested');
    }, this);

    return filtered;
  }.property('users.firstObject')
});

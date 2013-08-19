App.AdminController = Ember.Controller.extend({
  users: [],
  packages: [],
  groups: [],

  init: function() {
    this._super.apply(this, arguments);
    this.set('users', App.User.find());
    this.set('packages', App.Package.find());
    this.set('groups', App.Group.find());

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
          window.location.protocol, '//', window.location.host,
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

  packages: function() {
    return this.get('controllers.admin.packages');
  }.property('controllers.admin.packages'),

  groups: function() {
    return this.get('controllers.admin.groups');
  }.property('controllers.admin.groups'),

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
  showExamples: false,
  expandAll: false,
  count: 0,

  filterUsers: function() {
    var loading = this.get('isLoading');
    var all = this.get('users');
    var attributes = App.User.Filter.attributes;
    this.set('count', 0);

    // Parse the query.
    var query = this.get('query') || '';
    var parsedQuery = query.match(/\w+:(\w+|"[\w\s]+")/g);

    all.forEach(function(user) {
      if (query === null) {
        this.incrementProperty('count');
        user.set('hidden', false);
        return;
      }

      var showing;
      if (Ember.isNone(parsedQuery)) {
        showing = attributes.some(function(attribute) {
          return App.User.Filter[attribute](user, query);
        }, this);
      } else {
        showing = parsedQuery.every(function(elem) {
          elem = elem.split(':');
          var filter = elem[0];
          var search = elem[1];

          if (search.charAt(0) === '"') {
            search = search.slice(1, search.length - 1);
          }

          return attributes.contains(filter.toLowerCase()) && App.User.Filter[filter](user, search);
        }, this);
      }

      user.set('hidden', !showing);
      if (showing) {
        this.incrementProperty('count');
      }
    }, this);
  }.observes('users.length', 'query'),

  toggleExamples: function() {
    this.toggleProperty('showExamples');
  },

  toggleExpandAll: function() {
    this.toggleProperty('expandAll');
  },

  filter: function(text) {
    this.set('query', text);
  }
});

App.AdminUsersBursaryController = App.AdminSubController.extend({
  expandAll: false,
  filteredUsers: function() {
    var all = this.get('users');
    var filtered = all.filter(function(item) {
      return item.get('bursaryRequested');
    }, this);

    return filtered;
  }.property('users.firstObject'),

  toggleExpandAll: function() {
    this.toggleProperty('expandAll');
  }
});

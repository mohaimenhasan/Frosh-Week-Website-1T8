App.AdminController = Ember.Controller.extend({
  users: [],
  packages: [],
  groups: [],
  leedurs: [],
  hhfpackages: [],
  init: function() {
    this._super.apply(this, arguments);
    this.set('users', App.User.find());
    this.set('packages', App.Package.find());
    this.set('groups', App.Group.find());
    this.set('leedurs', App.Leedur.find());
    this.set('hhfpackages', App.HhfPackage.find());
    var that = this;
    if (Ember.isNone(window._offline)) {
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
            '&scope=https://www.googleapis.com/auth/userinfo.email',
            '&access_type=offline',
            '&approval_prompt=force'
          );
          url = url.join('');
          window.location = url;
        }
      }, 3000);
    }
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

  leedurs: function() {
    return this.get('controllers.admin.leedurs');
  }.property('controllers.admin.leedurs'),

  hhfpackages: function() {
    return this.get('controllers.admin.hhfpackages');
  }.property('controllers.admin.hhfpackages'),

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


App.AdminUsersSubController = App.AdminSubController.extend({
  expandAll: false,

  toggleExpandAll: function() {
    this.toggleProperty('expandAll');
  },

  deleteUser: function(user) {
    var result = window.confirm('Are you sure you want to delete the user?');
    if (result === true) {
      user.deleteRecord();
      user.get('transaction').commit();
    }
  },

  toggleCheckIn: function(user) {
    user.toggleProperty('checkedIn');
    user.get('transaction').commit();
  },

  sendTicket: function(user) {
    Ember.$.post('/api/leedurs/' + user.get('id') + '/send_receipt_email')
      .done(function() { window.alert('Sent!'); })
      .fail(function() { window.alert('Could not send ticket.'); });
  },

  sendConfirmation: function(user) {
    Ember.$.post('/api/leedurs/' + user.get('id') + '/send_confirmation_email')
      .done(function() { window.alert('Sent!'); })
      .fail(function() { window.alert('Could not send confirmation email.'); });
  },

  acceptBursary: function(user) {
    user.set('bursaryChosen', true);
    user.get('transaction').commit();
  },

  saveUser: function(user) {
    user.get('transaction').commit();
  }
});


App.AdminUsersController = App.AdminUsersSubController.extend({
  showExamples: false,
  page: 1,

  percentage: function() {
    return (100 * this.get('filteredUsers.length') / this.get('users.length')).toFixed(1);
  }.property('filteredUsers.length', 'users.length'),

  displayableUsers: function() {
    return this.get('filteredUsers').slice(0, 20 * this.get('page'));
  }.property('filteredUsers', 'page'),

  filteredUsers: function() {
    var all = this.get('users');
    var attributes = App.User.Filter.attributes;
    this.set('page', 1);

    // Parse the query.
    var query = this.get('query') || '';
    if (query === '') {
      return all;
    }

    var parsedQuery = query.match(/\w+:(\w+|"[\w\s]+")/g);
    var filtered = all.filter(function(user) {
      if (Ember.isNone(parsedQuery)) {
        return attributes.some(function(attribute) {
          return App.User.Filter[attribute](user, query);
        }, this);
      } else {
        return parsedQuery.every(function(elem) {
          elem = elem.split(':');
          var filter = elem[0];
          var search = elem[1];

          if (search.charAt(0) === '"') {
            search = search.slice(1, search.length - 1);
          }

          return attributes.contains(filter.toLowerCase()) && App.User.Filter[filter](user, search);
        }, this);
      }
    }, this);

    return filtered;
  }.property('users.@each', 'query'),

  pageIfNeeded: function() {
    if (this.get('filteredUsers.length') > 20 * this.get('page')) {
      this.incrementProperty('page');
    }
  },

  toggleExamples: function() {
    this.toggleProperty('showExamples');
  },

  filter: function(text) {
    this.set('query', text);
  }
});

App.AdminUsersBursaryController = App.AdminUsersSubController.extend({
  filteredUsers: function() {
    var all = this.get('users');
    var filtered = all.filter(function(item) {
      return item.get('bursaryRequested') && !item.get('bursaryChosen');
    }, this);

    return filtered;
  }.property('users.@each.bursaryRequested', 'users.@each.bursaryChosen')
});

App.AdminUsersCheckinController = App.AdminUsersSubController.extend({
  page: 1,

  isCheckin: true,

  remaining: function() {
    return this.get('controllers.admin.users.length') - this.get('users.length');
  }.property('users.length', 'controllers.admin.users.length'),

  checkedInPercentage: function() {
    return (100 * (this.get('remaining') / this.get('controllers.admin.users.length'))).toFixed(1);
  }.property('remaining', 'controllers.admin.users.length'),

  totalPercentage: function() {
    return (100 * this.get('filteredUsers.length') / this.get('users.length')).toFixed(1);
  }.property('filteredUsers.length', 'users.length'),

  users: function() {
    return this.get('controllers.admin.users').filter(function(user) {
      return !user.get('checkedIn');
    }, this);
  }.property('controllers.admin.users.@each', 'controllers.admin.users.@each.checkedIn'),

  displayableUsers: function() {
    return this.get('filteredUsers').slice(0, 20 * this.get('page'));
  }.property('filteredUsers', 'page'),

  filteredUsers: function() {
    var all = this.get('users');
    var attributes = App.User.Filter.attributes;
    this.set('page', 1);

    // Parse the query.
    var query = this.get('query') || '';
    if (query === '') {
      return all;
    }

    var parsedQuery = query.match(/\w+:(\w+|"[\w\s]+")/g);
    var filtered = all.filter(function(user) {
      if (Ember.isNone(parsedQuery)) {
        return attributes.some(function(attribute) {
          return App.User.Filter[attribute](user, query);
        }, this);
      } else {
        return parsedQuery.every(function(elem) {
          elem = elem.split(':');
          var filter = elem[0];
          var search = elem[1];

          if (search.charAt(0) === '"') {
            search = search.slice(1, search.length - 1);
          }

          return attributes.contains(filter.toLowerCase()) && App.User.Filter[filter](user, search);
        }, this);
      }
    }, this);

    return filtered;
  }.property('users.@each', 'query'),

  pageIfNeeded: function() {
    if (this.get('filteredUsers.length') > 20 * this.get('page')) {
      this.incrementProperty('page');
    }
  },

  filter: function(text) {
    this.set('query', text);
  }
});

App.AdminUsersRegisterController = Ember.Controller.extend({
  needs: ['admin'],

  packages: function() {
    return this.get('controllers.admin.packages');
  }.property('controllers.admin.packages'),
  
  formPackages: function() {
    var packages = this.get('packages') || [];
    return packages.map(function(item) {
      return item.get('key');
    });
  }.property('packages.firstObject'),

  packageId: 1,

  pkg: function(key, value) {
    var packages = this.get('packages');
    var pkg;

    if (arguments.length === 1) {
      var packageId = this.get('packageId');
      if (!Ember.isNone(packageId)) {
        packageId = packageId.toString();
      }

      if (!Ember.isNone(packages)) {
        pkg = packages.findProperty('id', packageId);
        return !Ember.isNone(pkg) ? pkg.get('key') : '-';
      }

      return '-';
    } else {
      if (!Ember.isNone(packages)) {
        pkg = packages.findProperty('key', value);
        if (!Ember.isNone(pkg)) {
          this.set('packageId', pkg.get('id'));
        }
      }
    }
  }.property('packageId')
});




/********************** Leedurs **************/
App.AdminLeedursSubController = App.AdminSubController.extend({
  expandAll: false,

  today: function() {
    return new Date();
  }.property(),

  registrationsToday: function() {
    var all = this.get('leedurs');
    return all.filter(function(item) {
      var creation = item.get('createdAt');
      var today = this.get('today');

      return today.getFullYear() === creation.getFullYear() &&
        today.getMonth() === creation.getMonth() &&
        today.getDate() === creation.getDate();
    }, this).length;
  }.property('leedurs.firstObject'),

  toggleExpandAll: function() {
    this.toggleProperty('expandAll');
  },

  deleteLeedur: function(leedur) {
    var result = window.confirm('Are you sure you want to delete the leedur?');
    if (result === true) {
      leedur.deleteRecord();
      leedur.get('transaction').commit();
    }
  },

  toggleCheckIn: function(leedur) {
    leedur.toggleProperty('checked_in');
    leedur.get('transaction').commit();
  },

  sendTicket: function(leedur) {
    Ember.$.post('/api/leedurs/' + leedur.get('id') + '/send_receipt_email')
      .done(function() { window.alert('Sent!'); })
      .fail(function() { window.alert('Could not send ticket.'); });
  },

  sendConfirmation: function(leedur) {
    Ember.$.post('/api/leedurs/' + leedur.get('id') + '/send_confirmation_email')
      .done(function() { window.alert('Sent!'); })
      .fail(function() { window.alert('Could not send confirmation email.'); });
  },

  saveLeedur: function(leedur) {
    leedur.get('transaction').commit();
  }
});

App.AdminLeedursController = App.AdminLeedursSubController.extend({
  showExamples: false,
  page: 1,

  percentage: function() {
    return (100 * this.get('filteredLeedurs.length') / this.get('leedurs.length')).toFixed(1);
  }.property('filteredLeedurs.length', 'leedurs.length'),

  displayableLeedurs: function() {
    return this.get('filteredLeedurs').slice(0, 20 * this.get('page'));
  }.property('filteredLeedurs', 'page'),

  filteredLeedurs: function() {
    var all = this.get('leedurs');
    var attributes = App.Leedur.Filter.attributes;
    this.set('page', 1);

    // Parse the query.
    var query = this.get('query') || '';
    if (query === '') {
      return all;
    }

    var parsedQuery = query.match(/\w+:(\w+|"[\w\s]+")/g);
    var filtered = all.filter(function(leedur) {
      if (Ember.isNone(parsedQuery)) {
        return attributes.some(function(attribute) {
          return App.Leedur.Filter[attribute](leedur, query);
        }, this);
      } else {
        return parsedQuery.every(function(elem) {
          elem = elem.split(':');
          var filter = elem[0];
          var search = elem[1];

          if (search.charAt(0) === '"') {
            search = search.slice(1, search.length - 1);
          }

          return attributes.contains(filter.toLowerCase()) && App.Leedur.Filter[filter](leedur, search);
        }, this);
      }
    }, this);
    return filtered;
  }.property('leedurs.@each', 'query'),

  pageIfNeeded: function() {
    if (this.get('filteredLeedurs.length') > 20 * this.get('page')) {
      this.incrementProperty('page');
    }
  },

  toggleExamples: function() {
    this.toggleProperty('showExamples');
  },

  filter: function(text) {
    this.set('query', text);
  }
});

App.AdminLeedursRegisterController = Ember.Controller.extend({
  needs: ['admin'],

  hhfpackages: function() {
    return this.get('controllers.admin.hhfpackages');
  }.property('controllers.admin.hhfpackages'),

  formPackages: function() {
    var packages = this.get('hhfpackages') || [];
    return packages.map(function(item) {
      return item.get('key');
    });
  }.property('hhfpackages.firstObject'),

  //FIXME: temp value for fweek
  packageId: 1,

  hhfpkg: function(key, value) {
    var packages = this.get('hhfpackages');
    var pkg;

    if (arguments.length === 1) {
      var packageId = this.get('packageId');
      if (!Ember.isNone(packageId)) {
        packageId = packageId.toString();
      }

      if (!Ember.isNone(packages)) {
        pkg = packages.findProperty('id', packageId);
        return !Ember.isNone(pkg) ? pkg.get('key') : '-';
      }

      return '-';
    } else {
      if (!Ember.isNone(packages)) {
        pkg = packages.findProperty('key', value);
        if (!Ember.isNone(pkg)) {
          this.set('packageId', pkg.get('id'));
        }
      }
    }
  }.property('packageId')
});
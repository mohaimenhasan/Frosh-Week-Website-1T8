App.UserElementView = Ember.View.extend({
  tagName: 'div',
  templateName: 'admin/user_element',

  user: null,
  expanded: false,
  editMode: false,

  genderIcon: function() {
    var gender = this.get('user.gender');
    if (gender) {
      if (gender === 'Male') {
        return 'icon-male';
      } else if (gender === 'Female') {
        return 'icon-female';
      }
    }

    return 'icon-lemon';
  }.property('user.gender'),

  group: function() {
    var groups = this.get('controller.groups');
    var groupId = this.get('user.groupId');
    if (!Ember.isNone(groupId)) {
      groupId = groupId.toString();
    }

    if (!Ember.isNone(groups)) {
      var group = groups.findProperty('id', groupId);
      return !Ember.isNone(group) ? group.get('name') + ' ' + group.get('symbol') : '-';
    }

    return '-';
  }.property('user.groupId', 'controller.groups.firstObject'),

  pkg: function(key, value) {
    var packages = this.get('controller.packages');
    var pkg;

    if (arguments.length === 1) {
      var packageId = this.get('user.packageId');
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
        this.set('user.packageId', pkg.get('id'));
      }
    }
  }.property('user.packageId', 'controller.packages.firstObject'),

  packagesSelect: function() {
    var packages = this.get('controller.packages');
    return packages.map(function(item) {
      return item.get('key');
    });
  }.property('controller.packages.firstObject'),

  restrictions: function() {
    var diet = (this.get('user.restrictionsDietary') || '').length > 0;
    var access = (this.get('user.restrictionsAccessibility') || '').length > 0;
    var misc = (this.get('user.restrictionsMisc') || '').length > 0;
    return diet || misc || access;
  }.property('user.restrictionsDietary', 'user.restrictionsAccessibility', 'user.restrictionsMisc'),

  init: function() {
    this._super.apply(this, arguments);
    this.addObserver('controller.expandAll', function() {
      var expand = this.get('controller.expandAll');
      this.set('expanded', expand || false);
    });
  },

  stopEdit: function() {
    if (!this.get('expanded')) {
      this.set('editMode', false);
    }
  }.observes('expanded'),

  toggleExpand: function() {
    this.toggleProperty('expanded');
  },

  toggleEdit: function() {
    this.set('expanded', true);
    this.toggleProperty('editMode');

    if (!this.get('editMode')) {
      this.get('controller').send('saveUser', this.get('user'));
    }
  }
});

App.LeedurElementView = Ember.View.extend({
  tagName: 'div',
  templateName: 'admin/leedur_element',

  leedur: null,
  expanded: false,
  editMode: false,

  genderIcon: function() {
    var gender = this.get('leedur.gender');
    if (gender) {
      if (gender === 'Male') {
        return 'icon-male';
      } else if (gender === 'Female') {
        return 'icon-female';
      }
    }

    return 'icon-lemon';
  }.property('leedur.gender'),


  hhfpkg: function(key, value) {
    var packages = this.get('controller.hhfpackages');
    var pkg;

    if (arguments.length === 1) {
      var packageId = this.get('leedur.hhf_package_id');
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
        this.set('leedur.hhf_package_id', pkg.get('id'));
      }
    }
  }.property('leedur.hhf_package_id', 'controller.hhfpackages.firstObject'),

  hhfpackagesSelect: function() {
    var packages = this.get('controller.hhfpackages');
    return packages.map(function(item) {
      return item.get('key');
    });
  }.property('controller.hhfpackages.firstObject'),

  restrictions: function() {
    var diet = (this.get('leedur.restrictionsDietary') || '').length > 0;
    var misc = (this.get('leedur.restrictionsMisc') || '').length > 0;
    return diet || misc ;
  }.property('leedur.restrictionsDietary', 'leedur.restrictionsMisc'),

  init: function() {
    this._super.apply(this, arguments);
    this.addObserver('controller.expandAll', function() {
      var expand = this.get('controller.expandAll');
      this.set('expanded', expand || false);
    });
  },

  stopEdit: function() {
    if (!this.get('expanded')) {
      this.set('editMode', false);
    }
  }.observes('expanded'),

  toggleExpand: function() {
    this.toggleProperty('expanded');
  },

  toggleEdit: function() {
    this.set('expanded', true);
    this.toggleProperty('editMode');

    if (!this.get('editMode')) {
      this.get('controller').send('saveLeedur', this.get('leedur'));
    }
  }
});

App.LoaderView = Ember.View.extend({
  tagName: 'div',
  viewed: false,

  didInsertElement: function() {
    var self = this;
    this.$().bind('inview', function(event, isInView) {
      var viewed = self.get('viewed');

      if (isInView) {
        if (!viewed) {
          self.set('viewed', true);
          self.get('controller').send('pageIfNeeded');
        }
      } else {
        self.set('viewed', false);
      }
    });
  }
});
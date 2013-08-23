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
App.UserElementView = Ember.View.extend({
  tagName: 'div',
  templateName: 'admin/user_element',

  user: null,
  expanded: false,

  genderIcon: function() {
    var gender = this.get('user.gender');
    if (gender) {
      if (gender === 'Male') {
        return 'icon-male';
      } else {
        return 'icon-female';
      }
    }

    return '';
  }.property('user.gender'),

  group: function() {
    var groupId = this.get('user.groupId');
    var group = App.Group.find(groupId);

    if (!Ember.isNone(group)) {
      return group.get('name') + ' ' + group.get('symbol');
    }

    return '-';
  }.property('user.groupId', 'controller.groups.firstObject'),

  pkg: function() {
    var packageId = this.get('user.packageId').toString();
    var pkg = App.Package.find(packageId);

    if (!Ember.isNone(pkg)) {
      return pkg.get('key');
    }

    return '-';
  }.property('user.packageId', 'controller.packages.firstObject'),

  init: function() {
    this._super.apply(this, arguments);
    this.addObserver('controller.expandAll', function() {
      var expand = this.get('controller.expandAll');
      this.set('expanded', expand || false);
    });
  },

  toggleExpand: function() {
    this.toggleProperty('expanded');
  }
});
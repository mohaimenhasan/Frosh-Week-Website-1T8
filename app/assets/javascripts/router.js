if (window.history && window.history.pushState) {
  App.Router.reopen({
    location: 'history'
  });
}

App.RouteList = [
  Ember.Object.create({ route: 'index', name: 'Home' }),
  Ember.Object.create({ route: 'schedule', name: 'Events & Schedule' }),
  Ember.Object.create({ route: 'faq', name: 'FAQs' }),
  Ember.Object.create({ route: 'groups', name: 'Groups' }),
  Ember.Object.create({ route: 'about', name: 'About Us' }),
  Ember.Object.create({ route: 'blog', name: 'Blog' }),
  Ember.Object.create({ route: 'register', name: 'Register Now' })
];

// TODO(johnliu): Handle hash routes.
App.Router.map(function() {
  var that = this;
  App.RouteList.forEach(function(item) {
    if (item.route != 'index')
      that.route(item.route);
  });

  this.route('none', { path: '*path'});
});

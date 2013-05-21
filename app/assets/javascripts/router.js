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
  Ember.Object.create({
    route: 'register', name: 'Register Now',
    routes: [
      { route: 'item', path: '/:item_name' }
    ]
  })
];

// TODO(johnliu): Handle hash routes.
App.Router.map(function() {
  var outerContext = this;
  App.RouteList.forEach(function(item) {

    if (item.route != 'index')
      outerContext.resource(item.route, function() {

        var innerContext = this;
        if (typeof item.routes !== 'undefined')
          item.routes.forEach(function(inner) {
            innerContext.route(inner.route, { path: inner.path });
          });
      });
  });

  this.route('none', { path: '*path'});
});

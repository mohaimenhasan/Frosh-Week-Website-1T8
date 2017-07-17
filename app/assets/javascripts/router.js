if (window.history && window.history.pushState) {
  App.Router.reopen({
    location: 'auto'
  });
}

App.RouteList = [
  Ember.Object.create({ route: 'index',    path: '/',          name: 'Home' }),
  Ember.Object.create({ route: 'schedule', path: '/schedule',  name: 'Events & Schedule' }),
  Ember.Object.create({ route: 'faq',      path: '/faq',       name: 'FAQs' }),
  Ember.Object.create({ route: 'volunteer',path: '/volunteerz' }),
//  Ember.Object.create({ route: 'groups',   path: '/groups',    name: 'Groups' }),
//  Ember.Object.create({ route: 'about',    path: '/about',     name: 'About' }),
  Ember.Object.create({
    route: 'blog',
    path: 'http://blog.orientation.skule.ca',
    name: 'Blog',
    external: true
  }),
  Ember.Object.create({
    route: 'registration',
    path: '/register',
    name: 'Register Now',
    routes: [
      Ember.Object.create({ route: 'item',    path: '/:key' }),
      Ember.Object.create({ route: 'receipt', path: '/receipt' }),
      Ember.Object.create({ route: 'bursary', path: '/bursary' }),
      Ember.Object.create({ route: 'confirm', path: '/confirm/:user/:token'})
//      Ember.Object.create({ route: 'payment', path: '/payment' }),
    ]
  }),



  Ember.Object.create({
    route: 'leedurhhf',
    path: '/leedurs_adventures',
    routes: [
      Ember.Object.create({ route: 'item',    path: '/:key' }),
      Ember.Object.create({ route: 'receipt', path: '/receipt' }),
      Ember.Object.create({ route: 'confirm', path: '/confirm/:user/:token'})
    ]
  }),
  Ember.Object.create({
    route: 'admin',
    path: '/admin',
    routes: [
      Ember.Object.create({ route: 'users',             path: '/users' }),
      Ember.Object.create({ route: 'usersRegister',     path: '/users/register' }),
      Ember.Object.create({ route: 'usersBursary',      path: '/users/bursary' }),
      Ember.Object.create({ route: 'usersCheckin',      path: '/users/checkin' }),
      Ember.Object.create({ route: 'usersCheckinUser',  path: '/users/checkin/:ticket' }),
      Ember.Object.create({ route: 'usersDetails',      path: '/users/:user' }),
      Ember.Object.create({ route: 'packages',          path: '/packages' }),
      Ember.Object.create({ route: 'leedurs',           path: '/leedurs' }),
      Ember.Object.create({ route: 'leedursRegister',   path: '/leedurs/register' }),
    ]
  })
];

App.Router.map(function() {
  var outerContext = this;
  App.RouteList.forEach(function(outer) {
    outerContext.resource(outer.get('route'), { path: outer.get('path') }, function() {
      var innerContext = this;
      if (outer.get('routes')) {
        outer.get('routes').forEach(function(inner) {
          innerContext.route(inner.get('route'), { path: inner.get('path') });
        });
      }
    });
  });

  this.route('none', { path: '*path'});
});

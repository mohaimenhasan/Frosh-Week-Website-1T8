if (window.history && window.history.pushState) {
  SkuleOrientation.Router.reopen({
    location: 'history'
  });
}

// TODO(johnliu): Handle hash routes.
SkuleOrientation.Router.map(function() {
  this.route('schedule');
  this.route('traditions');
  this.route('register');
  this.route('faq');
  this.route('groups');
  this.route('sponsors');
  this.route('register');
  this.route('froshnite');
  this.route('none', { path: '*path'});
});

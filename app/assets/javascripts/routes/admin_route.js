App.AdminRoute = Ember.Route.extend({
  model: function() {
    return App.Admin.find();
  },

  redirect: function() {
    return;

    if (!Ember.isNone(this.get('model'))) {
      var url = [];
      url.push(
        'https://accounts.google.com/o/oauth2/auth',
        '?response_type=code',
        '&client_id=1059117754088.apps.googleusercontent.com',
        '&redirect_uri=http://localhost:3000/auth',
        '&scope=https://www.googleapis.com/auth/userinfo.email'
      );
      url = url.join('');
      window.location = url;
    }
  }
});

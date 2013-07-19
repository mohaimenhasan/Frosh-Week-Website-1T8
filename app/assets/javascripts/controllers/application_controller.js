App.ApplicationController = Ember.Controller.extend({
  routeChanged: function() {
    if (!window._gaq) {
      return;
    }

    Ember.run.next(function() {
      var page;
      page = window.location.hash.length > 0 ? window.location.hash.substring(1) : window.location.pathname;
      _gaq.push(['_trackPageview', page]);
    });
  }.observes('currentPath')
});

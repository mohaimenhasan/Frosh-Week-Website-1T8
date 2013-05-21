App.HeaderController = Ember.ArrayController.extend({
  content: App.RouteList,
  itemController: 'header_item'
});

App.HeaderItemController = Ember.ObjectController.extend({
  needs: ['application'],

  active: function() {
    var current = this.get('controllers.application.currentPath');
    var route = this.get('route');

    var sep = current.indexOf('.');
    current = sep >= 0 ? current.substring(0, sep) : current;

    return current === route;
  }.property('route', 'controllers.application.currentPath'),

  select: function(evt) {
    this.transitionToRoute(this.get('route'));
  }
});

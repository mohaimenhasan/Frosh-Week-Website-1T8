App.HeaderController = Ember.ArrayController.extend({
  content: App.RouteList,
  itemController: 'header_item'
});

App.HeaderItemController = Ember.ObjectController.extend({
  needs: ['application'],

  active: function() {
    return (this.get('controllers.application.currentPath') == this.get('route'));
  }.property('route', 'controllers.application.currentPath'),

  select: function(evt) {
    this.transitionToRoute(this.get('route'));
  }
});

App.IndexController = Ember.Controller.extend({
  daysRemaining: function() {
    var end = new Date('Sept 05 2016 23:59:59 EDT');
    var current = new Date();

    var days = (end - current) / 1000 / 60 / 60 / 24;
    return 0;
  }.property(),

  hasStarted: function() {
    return this.get('daysRemaining') <= 0;
  }.property('daysRemaining'),

  showVideo: function(event) {
    this.set('videoShowing', true);
    return false;
  }

});

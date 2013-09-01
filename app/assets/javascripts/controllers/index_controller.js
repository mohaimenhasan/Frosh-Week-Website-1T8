App.IndexController = Ember.Controller.extend({
  daysRemaining: function() {
    var end = new Date('Sept 02 2013 23:59:59 EDT');
    var current = new Date();

    var days = (end - current) / 1000 / 60 / 60 / 24;
    return parseInt(days, 10);
  }.property(),

  showVideo: function(event) {
    this.set('videoShowing', true);
    return false;
  }
});
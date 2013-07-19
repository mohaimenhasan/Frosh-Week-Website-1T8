App.ScheduleEventView = Ember.View.extend({
  classNameBindings: ['active'],

  active: function() {
    return this.get('controller.activeElement') === this.get('elementId');
  }.property('controller.activeElement'),

  click: function() {
    if (this.get('active')) {
      this.set('controller.activeElement', '');
    } else {
      this.set('controller.activeElement', this.get('elementId'));
    }

    return false;
  }
});
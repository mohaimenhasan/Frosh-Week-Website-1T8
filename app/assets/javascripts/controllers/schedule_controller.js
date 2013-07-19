App.ScheduleController = Ember.Controller.extend({
  activeElement: '',

  click: function() {
    this.set('activeElement', '');
  }
});
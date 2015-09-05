App.ScheduleController = Ember.Controller.extend({
  //Schedule Slot activate logic
  activeElement: '',

  click: function() {
    this.set('activeElement', '');
  },
    
  //Gallery
  galleryShowing: false,
    
  showGallery: function() {
    this.set('galleryShowing', true);
    return false;
  },

  AltEvents: false,
  toggleEvents: function() {
    this.set('AltEvents', !this.get('AltEvents'));
    Ember.Logger.log(this.get('AltEvents'));
    return false;
  }
});
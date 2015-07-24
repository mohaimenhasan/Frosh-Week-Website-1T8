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
  }
});
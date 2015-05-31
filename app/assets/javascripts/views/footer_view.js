App.FooterView = Ember.View.extend({
  didInsertElement: function(){
    this.$("#snapchat-footer-icon").click(function(e){
      Ember.Logger.log("toggled");
      $("#snapchat-footer-message").fadeToggle("slow");
      e.stopImmediatePropagation();
    });
  }
});

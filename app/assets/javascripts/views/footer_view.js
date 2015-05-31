App.FooterView = Ember.View.extend({
  didInsertElement: function(){
    this.$("#snapchat-footer-icon").click(function(e){
      Ember.Logger.log("toggled");
      $("#snapchat-footer-message").fadeToggle("slow");
      e.stopImmediatePropagation();
    });
    this.$(document).click(function(e){
      Ember.Logger.log("document");
      if($("#snapchat-footer-icon").is(":visible") && 
        !$("#snapchat-footer-message").is(e.target)){
        $("#snapchat-footer-message").fadeOut("slow");
      }
      
    });
  }
});

App.FooterView = Ember.View.extend({
  didInsertElement: function(){
    this.$("#snapchat-footer-icon").click(function(e){

      $("#snapchat-footer-message").fadeToggle("slow");
      e.stopImmediatePropagation();
    });
    //On document ready: preload-image
    this.$(document).ready(function(){
      var snap_grey = new Image();
      snap_grey.src = "/assets/icons/snapchat-gray.png";
    });
    //On document click: message should disappear
    this.$(document).click(function(e){
      
      if($("#snapchat-footer-icon").is(":visible") && 
        !$("#snapchat-footer-message").is(e.target)){
        $("#snapchat-footer-message").fadeOut("slow");
      }
      
    });
  }
});

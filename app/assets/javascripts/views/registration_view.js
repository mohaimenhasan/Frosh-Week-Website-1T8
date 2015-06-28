App.RegistrationIndexView = Ember.View.extend({
  
    
  click: function(){
    var that = this;
    this.$("#early-bird-standalone").click(function(e){
      var value = $('#early-bird-standalone').is(":checked");
      that.set('controller.earlyBirdSelected', value);
      e.stopImmediatePropagation();
    });
    this.$("#standalone").click(function(e){
      var value = $('#standalone').is(":checked");
      that.set('controller.regularSelected', value);
      e.stopImmediatePropagation();
    });
    this.$("#farm").click(function(e){
      var value = $('#farm').is(":checked");
      that.set('controller.hhfSelected', value);
      e.stopImmediatePropagation();
    });
    this.$("#commuter").click(function(e){
      var value = $('#commuter').is(":checked");
      that.set('controller.commuterSelected', value);
      e.stopImmediatePropagation();
    });
  }
});


App.RegistrationConfirmView = Ember.View.extend ({

  
  startAnimation: function() {
    
    if(this.get("controller.enableAnimation")){
      Ember.Logger.log("Starting Gif");
      var that = this;
      $("#sortingHat_Full").fadeOut("fast");
      $("#sorting_hat").one("load", function() {
          //As soon as done, then fade in slow
          $("#sortingHat_gif_container").fadeIn("slow"); 
      }).attr("src", "https://froshweek-staging.herokuapp.com/assets/sorting_hat/sorting_hat_1_syll.gif");
      
     
      setTimeout(function(){
          //Not yet done here, just need the message to be ready so we can load the link on
            that.set("controller.doneAnimation", true);
      }, 1000);
      //Wait for animation to be done  
      setTimeout(function(){
        Ember.Logger.log(that.get("controller.group")); 
        Ember.Logger.log(that.get("controller.group.facebook_link"));
        $("#sortingHat_gif_container").fadeOut("slow"); 
        $("#sortingHat_Full").fadeIn("slow");
        //Since for some reason, unable to get group.facebook_link, create on the spot
        var groupName = that.get("controller.group.name").toLowerCase();
        var linkstr = "http://facebook.com/groups/" + groupName + ".1t5";
        $("#group_link").attr("href", linkstr);
        that.set("controller.displayFroshGroup", true);
      },12500); 
       
    }
       
  }.observes("controller.enableAnimation"),
  
  click: function(event) {
    var clickedElement = $(event.target).attr('id');
    Ember.Logger.log("Clicked", clickedElement);

    if(clickedElement == "viewSortinghat" &&
       !(clickedElement == "sortingHat_messageBox")){
      if(this.get("controller.displayFroshGroup")) {
        this.set("controller.messageShowing", false);
        $("#froshgroup").fadeIn("slow");
      }
      Ember.Logger.log("Clicked background", this.get("controller.showDoneAnimation"));
    
          
    }   
    
  }
  
});
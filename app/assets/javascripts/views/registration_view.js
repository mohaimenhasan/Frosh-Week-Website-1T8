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
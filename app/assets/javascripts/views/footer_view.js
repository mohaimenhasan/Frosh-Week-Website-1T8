App.FooterView = Ember.View.extend({
  didInsertElement: function(){
    this.$(document).click(function(e){
      Ember.Logger.log("document");
      
    });
  }
});

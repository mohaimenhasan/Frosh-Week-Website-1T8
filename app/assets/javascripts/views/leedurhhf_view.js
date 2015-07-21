App.LeedurhhfIndexView = Ember.View.extend({
  
    
  click: function(){
    var that = this;
    this.$("#leedur").click(function(e){
      var value = $('#leedur').is(":checked");
      that.set('controller.leedurSelected', value);
      e.stopImmediatePropagation();
    });
    this.$("#fweek").click(function(e){
      var value = $('#fweek').is(":checked");
      that.set('controller.fweekSelected', value);
      e.stopImmediatePropagation();
    });

  }
});
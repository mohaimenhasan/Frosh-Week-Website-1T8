App.LeedurhhfIndexView = Ember.View.extend({


  click: function(){
    var that = this;
    this.$("#leedur").click(function(e){
      var value = $('#leedur').is(":checked");
      that.set('controller.leedurSelected', value);
      e.stopImmediatePropagation();
    });
    this.$("#leedurnobus").click(function(e){
      var value = $('#leedurnobus').is(":checked");
      that.set('controller.leedurnobusSelected', value);
      e.stopImmediatePropagation();
    });
    this.$("#shirt").click(function(e){
      var value = $('#shirt').is(":checked");
      that.set('controller.shirtSelected', value);
      e.stopImmediatePropagation();
    });
    this.$("#shirtm").click(function(e){
      var value = $('#shirtm').is(":checked");
      that.set('controller.shirtmSelected', value);
      e.stopImmediatePropagation();
    });
this.$("#shirtxl").click(function(e){
      var value = $('#shirtxl').is(":checked");
      that.set('controller.shirtxlSelected', value);
      e.stopImmediatePropagation();
    });
  }
});

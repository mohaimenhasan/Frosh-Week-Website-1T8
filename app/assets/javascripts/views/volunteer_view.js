/*App.VolunteerView = Ember.View.extend({


  click: function(event){
    var that = this;
    var element = $(event.target);
    Ember.Logger.log("Clicked", element);
    this.$("input[type=checkbox]").click(function(e){
      Ember.Logger.log("Checkbox clicked");
      var elementId = element.attr('for');
      var value = $("#"+elementId).is(":checked");
      Ember.Logger.log(elementId, value, 'controller.selected.'+ elementId);
      that.set('controller.selected.'+ elementId, value);
      e.stopImmediatePropagation();
    });


  }
});*/

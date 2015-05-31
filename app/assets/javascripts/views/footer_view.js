//General Index: snapchat message appear
App.FooterView = Ember.View.extend({
  didInsertElement: function() {
    this._super();
    Ember.Logger.log("toggled_footer");
    Ember.run.next(function() {
      this.$("#snapchat-footer-icon").click(function(e){
        Ember.Logger.log("toggled_footer_run");
        $("#snapchat-message").fadeIn("slow");
        window.location.hash = "#snapchat-message";
        e.stopImmediatePropagation();
      }
    }
  }
});

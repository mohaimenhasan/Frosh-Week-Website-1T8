App.LeedurhhfIndexController = Ember.Controller.extend({
//Update total Price by getting checkbox value
  leedurSelected: false,
  fweekSelected: false,
 
//Enable EarlyBird or Standalone
  init: function() {
    var that = this;
    this.addObserver('model', function() {
      this.get('model');
    });
  },
  leedur: function() {
    var leedur = this.get("model").objectAt(0);
    return leedur;
  }.property("model.[]"),

  fweek: function() {
    var fweek = this.get("model").objectAt(1);
    return fweek;
  }.property("model.[]"),

  isError: false,
  isLoaded: false,
    
  isLoading: function() {
    var that = this;
    //TimeOut
    setTimeout(function(){
        if(!that.get("isLoaded")) {
          that.set("isLoading", false);
          that.set("isLoaded", !Ember.isNone(that.get('leedur')));
          that.set("isError", Ember.isNone(that.get('leedur')));
        }
    }, 60000);
    this.set("isLoaded", !Ember.isNone(this.get('leedur')));
    return Ember.isNone(this.get('leedur'));
  }.property('leedur'),
    
//disable CheckOut
  checkOutDisable: function () {
    var value =  (this.get("leedurSelected") || this.get("fweekSelected"));
    //if nothing selected, disable should be true
    return !value;
  }.property("leedurSelected", "fweekSelected"),

//totalPrice
  totalPrice: function() {
    var totalPrice = 0;
    totalPrice += this.get('leedurSelected')? Number($('#leedur').attr("value")) : 0;
    totalPrice += this.get('fweekSelected')? Number($('#fweek').attr("value")) : 0;

    return totalPrice;
  }.property('leedurSelected', 'fweekSelected'),
//Event when check out is clicked
    
  
    
  checkOutClicked: function() {
      //Only happen if enabled
    if(!this.get("checkOutDisable")) {
      //Compute package string and transition
      //At this point package should not be null
      var package = "";
      package += this.get('leedurSelected')? "leedur" : "";
      package += this.get('fweekSelected')? "_fweek" : "";
      
      //Transitioning
      //TODO: Creating json on the spot and pass as model
      /*var item = App.Package.find({key: package});
      
      
      //Transition as soon as finish loading up the selected model
      var that = this;
      item.one('didLoad', function() {
        //Need to reset value in case user do backpost, do it here so that user doesn't notice
        that.set("earlyBirdSelected", false);
        that.set("regularSelected", false);
        that.set("hhfSelected", false);
        that.set("commuterSelected", false);
        that.transitionToRoute("registration.item", item);  
      })*/
      
    }
  },
  
});


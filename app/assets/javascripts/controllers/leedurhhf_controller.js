App.LeedurhhfIndexController = Ember.Controller.extend({
//Update total Price by getting checkbox value
  leedurSelected: false,
  fweekSelected: false,
 

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
    totalPrice += this.get('leedurSelected')? this.get("leedur").get("price") : 0;
    totalPrice += this.get('fweekSelected')? this.get("fweek").get("price") : 0;

    return totalPrice;
  }.property('leedurSelected', 'fweekSelected'),
//Event when check out is clicked
    
  
    
  checkOutClicked: function() {
      //Only happen if enabled
    if(!this.get("checkOutDisable")) {
      //Compute key string and transition
      //At this point key should not be null
      var key = "";
      key += this.get('leedurSelected')? "leedur_" : "";
      key += this.get('fweekSelected')? "fweek_" : "";
      key = key.substring(0, key.length - 1);
      
      //Transitioning
      var item = App.HhfPackage.find({key: key});
      
      
      //Transition as soon as finish loading up the selected model
      var that = this;
      item.one('didLoad', function() {
        //Need to reset value in case user do backpost, do it here so that user doesn't notice
        that.set("leedurSelected", false);
        that.set("fweekSelected", false);
        that.transitionToRoute("leedurhhf.item", item);
      });
      
      
    }
  },
  
});

App.LeedurhhfItemController = Ember.Controller.extend({
  //Invoked by "Change kit" button, refer to item.hbs in leedurhhf
  cancel: function() {
    this.transitionToRoute('leedurhhf.index');
  }
});


App.LeedurhhfReceiptController = Ember.Controller.extend({
  selectedPackage: function() {
    var packageId = this.get('model.hhf_package_id');
    Ember.Logger.log(packageId);
    return App.HhfPackage.find(packageId);
  }.property('model.hhf_package_id'),

  init: function() {
    var that = this;
    this.addObserver('model', function() {
      if (!this.get('model')) {
        that.transitionToRoute('leedurhhf.index');
      }
    });
  },

  print: function() {
    window.print();
  }
});

App.LeedurhhfConfirmController = Ember.Controller.extend({

  
  //Actual Form  
  firstTime: false,

  hhfpackage: function() {
    return App.HhfPackage.find(this.get('model.hhf_package_id'));
  }.property('model.hhf_package_id'),


  url: function() {
    var api = 'https://chart.googleapis.com/chart?chs=450x450&cht=qr&chld=H|0&chl=';
    var host = window.location.host;
    var path = '/admin/leedurs/checkin/';

    return api + host + path + this.get('model.ticketNumber');
  }.property('model.ticketNumber'),


  showDietary: function() {
    var dietary = this.get('model.restrictionsDietary');
    return dietary && dietary.length > 0;
  }.property('model.restrictionsDietary'),

  showMisc: function() {
    var misc = this.get('model.restrictionsMisc');
    return misc && misc.length > 0;
  }.property('model.restrictionsMisc'),

  showReceipt: function() {
    var model = this.get('model');
    return model && model.get('verified');
  }.property('model'),

  showConfirmed: function() {
    return this.get('firstTime')  && this.get('model.verified');
  }.property('firstTime', 'model.verified'),

  showAlreadyVerified: function() {
    var model = this.get('model');
    return (!this.get('firstTime') && model && model.get('verified'));
  }.property('firstTime', 'model'),

  showError: function() {
    var model = this.get('model');
    Ember.Logger.log(model);
    return !model || !model.get('verified');
  }.property('model'),

  init: function() {
    this.addObserver('model', function() {
      var model = this.get('model');
      if (model) {
        var verified = model.get('verified');
        Ember.Logger.log("verified");
        this.set('firstTime', this.get('firstTime') || !verified);

        if (!verified) {
          model.set('verified', true);
          Ember.Logger.log("Setting verified to true");
          model.get('store').commit ();
        }
      }
    });
  },

  print: function() {
    window.print();
  }
});

App.RegistrationIndexController = Ember.Controller.extend({
//F YOU EMBER EASYFORM EASY MY...
//Update total Price by getting checkbox value
  earlyBirdSelected: false,
  regularSelected: false,
  hhfSelected: false,
  commuterSelected: false,
//disable CheckOut
  checkOutDisable: function () {
    var value =  (this.get("earlyBirdSelected") || this.get("regularSelected"));
    //if nothing selected, disable should be true
    return !value;
  }.property("earlyBirdSelected", "regularSelected"),
//totalPrice
  totalPrice: function() {
    var totalPrice = 0;
    totalPrice += this.get('earlyBirdSelected')? Number($('#early-bird-standalone').attr("value")) : 0;
    totalPrice += this.get('regularSelected')? Number($('#standalone').attr("value")) : 0;
    totalPrice += this.get('hhfSelected')? Number($('#farm').attr("value")) : 0;
    totalPrice += this.get('commuterSelected')? Number($('#commuter').attr("value")) : 0;

    return totalPrice;
  }.property('earlyBirdSelected', 'regularSelected', 'hhfSelected' , 'commuterSelected'),
//Event when check out is clicked
    
  
    
  checkOutClicked: function() {
      //Only happen if enabled
    if(!this.get("checkOutDisable")) {
      //Compute package string and transition
      //At this point package should not be null
      var package = "";
      package += this.get('earlyBirdSelected')? "early-bird-standalone" : "";
      package += this.get('regularSelected')? "standalone" : "";
      package += this.get('hhfSelected')? "_farm" : "";
      package += this.get('commuterSelected')? "_commuter" : "";
      
      //Transitioning
      var item = App.Package.find({key: package});
      
      
      //Transition as soon as finish loading up the selected model
      var that = this;
      item.one('didLoad', function() {
        //Need to reset value in case user do backpost, do it here so that user doesn't notice
        that.set("earlyBirdSelected", false);
        that.set("regularSelected", false);
        that.set("hhfSelected", false);
        that.set("commuterSelected", false);
        that.transitionToRoute("registration.item", item);  
      })
      
    }
  },
  updateAddons: function() {
    //Enable Addons
    if(this.get('earlyBirdSelected') || this.get('regularSelected')){
      $('#farm').removeAttr('disabled');  
      $('#commuter').removeAttr('disabled');
    }
    else {
    //Disable all addons
      $('#farm').attr("checked", false);
      $('#commuter').attr("checked", false);
      $('#farm').attr('disabled', true);  
      $('#commuter').attr('disabled', true);  
      this.set("hhfSelected", false);
      this.set("commuterSelected", false);
    }
  }.observes('earlyBirdSelected', 'regularSelected')
  
});


App.RegistrationItemController = Ember.Controller.extend({
  //Invoked by "Change kit" button, refer to item.hbs in registration
  cancel: function() {
    this.transitionToRoute('registration.index');
  }
});

App.RegistrationReceiptController = Ember.Controller.extend({
  selectedPackage: function() {
    var packageId = this.get('model.packageId');
    return App.Package.find(packageId);
  }.property('model.packageId'),

  init: function() {
    var that = this;
    this.addObserver('model', function() {
      if (!this.get('model')) {
        that.transitionToRoute('registration.index');
      }
    });
  },

  print: function() {
    window.print();
  }
});

App.RegistrationBursaryController = Ember.Controller.extend({
  init: function() {
    var that = this;
    this.addObserver('model', function() {
      if (!this.get('model')) {
        that.transitionToRoute('registration.index');
      }
    });
  }
});

App.RegistrationConfirmController = Ember.Controller.extend({
  firstTime: false,

  url: function() {
    var api = 'https://chart.googleapis.com/chart?chs=450x450&cht=qr&chld=H|0&chl=';
    var host = window.location.host;
    var path = '/admin/users/checkin/';

    return api + host + path + this.get('model.ticketNumber');
  }.property('model.ticketNumber'),

  group: function() {
    return App.Group.find(this.get('model.groupId'));
  }.property('model.groupId'),

  shirtSize: function() {
    return App.UserFormShirtHash[this.get('model.shirtSize')];
  }.property('model.shirtSize'),

  showDietary: function() {
    var dietary = this.get('model.restrictionsDietary');
    return dietary && dietary.length > 0;
  }.property('model.restrictionsDietary'),

  showAccessibility: function() {
    var accessibility = this.get('model.restrictionsAccessibility');
    return accessibility && accessibility.length > 0;
  }.property('model.restrictionsAccessibility'),

  showMisc: function() {
    var misc = this.get('model.restrictionsMisc');
    return misc && misc.length > 0;
  }.property('model.restrictionsMisc'),

  showReceipt: function() {
    var model = this.get('model');
    return model && model.get('verified') && (!model.get('bursaryRequested') || (model.get('bursaryPaid') || model.get('bursaryChosen')));
  }.property('model'),

  showConfirmed: function() {
    return this.get('firstTime')  && this.get('model.verified');
  }.property('firstTime', 'model.verified'),

  showAlreadyVerified: function() {
    var model = this.get('model');
    return !this.get('firstTime') && model && model.get('verified') && !(!model.get('bursaryRequested') || model.get('bursaryPaid') || model.get('bursaryChosen'));
  }.property('firstTime', 'model'),

  showError: function() {
    var model = this.get('model');
    return !model || !model.get('verified');
  }.property('model'),

  init: function() {
    this.addObserver('model', function() {
      var model = this.get('model');
      if (model) {
        var verified = model.get('verified');
        this.set('firstTime', this.get('firstTime') || !verified);

        if (!verified) {
          model.set('verified', true);
          model.get('store').commit();
        }
      }
    });
  },

  print: function() {
    window.print();
  }
});

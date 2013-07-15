App.RegistrationItemController = Ember.Controller.extend({
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

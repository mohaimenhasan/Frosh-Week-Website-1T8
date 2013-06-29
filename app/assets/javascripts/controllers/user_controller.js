App.UserController = Ember.ObjectController.extend({
  needs: ['packagesItem'],

  userPhone: function() {
    var content = this.get('content');

    var areaCode = content.get('phoneAreaCode');
    var start = content.get('phoneStart');
    var end = content.get('phoneEnd');

    if (areaCode && start && end) {
      return areaCode.toString() + start.toString() + end.toString();
    }
  }.property('content.phoneAreaCode', 'content.phoneStart', 'content.phoneEnd'),

  userEmergencyPhone: function() {
    var content = this.get('content');

    var areaCode = content.get('emergencyPhoneAreaCode');
    var start = content.get('emergencyPhoneStart');
    var end = content.get('emergencyPhoneEnd');

    if (areaCode && start && end) {
      return areaCode.toString() + start.toString() + end.toString();
    }
  }.property('content.emergencyPhoneAreaCode', 'content.emergencyPhoneStart', 'content.emergencyPhoneEnd'),

  init: function() {
    this._super();
    this.set('content', App.UserForm.create({}));
  },

  submit: function() {
    var selectedPackage = this.get('controllers.packagesItem').get('model');
    var content = this.get('content');

    // Prepare parts of the user object from form data.
    var userCCExpirationYear = parseInt(content.get('ccExpirationYear')) + 2000;
    var userCCExpirationMonth = parseInt(content.get('ccExpirationMonth')) - 1;
    var submitButton = Ladda.create(document.querySelector('button[type=submit]'));

    var that = this;
    var handleTransaction = function(status, response) {
      if (response.error) {
        console.log(response.error);
      } else {
        console.log(response['id']);

        var transaction = that.get('store').transaction();
        transaction.createRecord(App.User, {
          email: content.get('email'),
          verified: false,
          // creation date must be set on server.

          firstName: content.get('firstName'),
          lastName: content.get('lastName'),
          gender: content.get('gender'),
          phone: that.get('userPhone') || '',
          residence: content.get('residence'),
          discipline: content.get('discipline'),

          packageId: selectedPackage.get('id'),
          shirtSize: content.get('shirtSize'),
          // group must be set on the server.
          bursaryRequested: !!content.get('bursary'),
          // bursaryChosen must be set on the server.

          emergencyName: content.get('emergencyName'),
          emergencyEmail: content.get('emergencyEmail'),
          emergencyRelationship: content.get('emergencyRelationship'),
          emergencyPhone: that.get('userEmergencyPhone') || '',

          restrictionsDietary: content.get('restrictionsDietary'),
          restrictionsAccessibility: content.get('restrictionsAccessibility'),
          restrictionsMisc: content.get('restrictionsMisc'),

          ccToken: response['id']
        });
        transaction.commit();
        if (transaction.isValid()) {
          console.log('lol valid');
        } else {
          console.log('nope');
        }
      }
      submitButton.stop();
    };

    submitButton.start();
    if (content.get('bursary')) {
      handleTransaction(null, { id: 0 });
    } else {
      Stripe.card.createToken({
        number: content.get('ccNumber'),
        cvc: content.get('ccCVC'),
        exp_month: userCCExpirationMonth,
        exp_year: userCCExpirationYear
      }, handleTransaction);
    }
  }
});

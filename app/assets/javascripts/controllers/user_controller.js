App.UserController = Ember.ObjectController.extend({
  needs: ['packagesItem'],

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
        // This should never happen since we validate client side.
        content.set('error', true);
        submitButton.stop();
      } else {
        var transaction = that.get('store').transaction();
        var record = transaction.createRecord(App.User, {
          email: content.get('email'),
          // verified must be set on server.
          // creation date must be set on server.

          firstName: content.get('firstName'),
          lastName: content.get('lastName'),
          gender: content.get('gender'),
          phone: content.get('phone') || '',
          residence: content.get('residence'),
          discipline: content.get('discipline'),

          packageId: selectedPackage.get('id'),
          shirtSize: content.get('shirtSize'),
          // group must be set on the server.
          bursaryRequested: !!content.get('bursary'),
          // bursaryChosen must be set on the server.
          // bursaryPaid must be set on server.
          bursaryScholarshipAmount: content.get('bursaryPaid') || 0,
          bursaryEngineeringMotivation: content.get('bursaryEngineeringMotivation') || '',
          bursaryFinancialReasoning: content.get('bursaryFinancialReasoning') || '',
          bursaryAfterGraduation: content.get('bursaryAfterGraduation') || '',

          emergencyName: content.get('emergencyName'),
          emergencyEmail: content.get('emergencyEmail'),
          emergencyRelationship: content.get('emergencyRelationship'),
          emergencyPhone: content.get('emergencyPhone'),

          restrictionsDietary: content.get('restrictionsDietary'),
          restrictionsAccessibility: content.get('restrictionsAccessibility'),
          restrictionsMisc: content.get('restrictionsMisc'),

          ccToken: response['id']
        });
        transaction.commit();

        record.on('didCreate', function() {
          // Transition to receipt page.
          submitButton.stop();
        });

        record.on('becameError', function() {
          content.set('error', true);
          submitButton.stop();
        });

        record.on('becameInvalid', function() {
          var errors = record.get('errors');

          for (var key in errors) {
            if (key == 'stripe') {

            } else if (errors.hasOwnProperty(key)) {
              content.set('errors.' + key, errors[key][0]);
            }
          }

          content.set('error', true);
          submitButton.stop();
        });
      }
    };

    submitButton.start();
    content.set('error', false);
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

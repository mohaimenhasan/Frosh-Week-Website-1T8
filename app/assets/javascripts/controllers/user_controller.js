App.UserController = Ember.ObjectController.extend({
  needs: ['registrationItem', 'registrationReceipt', 'registrationBursary'],

  trackError: function(field, type, errorValue) {
    if (!window._gaq) {
      return;
    }

    Ember.run.next(function() {
      _gaq.push(['_trackEvent', 'Registration Error', field, type + ': ' + errorValue]);
    });
  },

  showAccessibilityInfo: false,

  serverError: false,

  showError: function() {
    return this.get('serverError') || !this.get('content.isValid');
  }.property('serverError', 'content.isValid'),

  init: function() {
    this._super.apply(this, arguments);
    this.set('content', App.UserForm.create({ isValid: true, bursary: false }));

    var that = this;
    this.addObserver('content.bursary', function() {
      var content = that.get('content');

      // Validate opposite of toggle, to clear previous validations.
      if (content.get('bursary')) {
        content.validate('ccName');
        content.validate('ccNumber');
        content.validate('ccCVC');
        content.validate('ccExpiration');
      } else {
        content.validate('bursaryEngineeringMotivation');
        content.validate('bursaryFinancialReasoning');
      }
    });
  },

  toggleAccessibilityInfo: function() {
    this.set('showAccessibilityInfo', !this.get('showAccessibilityInfo'));
  },

  stripeError: function(code) {
    var content = this.get('content');
    if (code === 'incorrect_number' || code === 'invalid_number' ||
        code === 'expired_card' || code === 'card_declined' || code === 'processing_error') {
      content.set('errors.ccNumber', 'Invalid card number.');
      this.trackError('ccNumber:' + code, 'client', 'cc number failure');
    } else if (code === 'invalid_expiry_month' || code === 'invalid_expiry_year') {
      content.set('errors.ccExpiration', 'Invalid expiration date.');
      this.trackError('ccNumber:' + code, 'client', 'cc expiration failure');
    } else if (code === 'invalid_cvc' || code === 'incorrect_cvc') {
      content.set('errors.ccCVC', 'Invalid CVC.');
      this.trackError('ccCVC', 'client', 'cvc failure');
    } else {
      this.trackError('ccUnknown', 'client', content.get('Unknown error, email: ' + content.get('email')));
      return false;
    }

    return true;
  },

  submit: function() {
    var selectedPackage = this.get('controllers.registrationItem').get('model');
    var content = this.get('content');

    // Prepare parts of the user object from form data.
    var submitButton = Ladda.create(document.querySelector('button[type=submit]'));

    var that = this;
    var handleTransaction = function(status, response) {
      console.log('post-delayed');
      console.log(status);
      console.log(response);
      if (response.error) {
        if (response.error.hasOwnProperty('code')) {
          if (!that.stripeError(response.error.code)) {
            content.set('serverError', true);
          } else {
            content.set('isValid', false);
          }
        }
        submitButton.stop();
      } else {
        var transaction = that.get('store').transaction();
        var record = transaction.createRecord(App.User, {
          email: content.get('email'),
          // verified must be set on server.
          // createdAt must be set on server.
          // confirmationToken must be set on server.
          // ticketNumber must be set on the server.

          firstName: content.get('firstName'),
          lastName: content.get('lastName'),
          gender: content.get('gender'),
          phone: content.get('phone') || '',
          // residence is no longer set
          discipline: content.get('discipline'),

          packageId: selectedPackage.get('id'),
          shirtSize: content.get('shirtSize'),
          // group must be set on the server.
          bursaryRequested: !!content.get('bursary'),
          // bursaryChosen must be set on the server.
          // bursaryPaid must be set on server.
          bursaryOsap: content.get('bursaryOsap') || false,
          bursaryEngineeringMotivation: content.get('bursaryEngineeringMotivation') || '',
          bursaryFinancialReasoning: content.get('bursaryFinancialReasoning') || '',

          emergencyName: content.get('emergencyName'),
          emergencyEmail: content.get('emergencyEmail'),
          emergencyRelationship: content.get('emergencyRelationship'),
          emergencyPhone: content.get('emergencyPhone'),

          restrictionsDietary: content.get('restrictionsDietary'),
          restrictionsAccessibility: content.get('restrictionsAccessibility'),
          restrictionsMisc: content.get('restrictionsMisc'),

          // chargeId must not be used.
          ccToken: response.id
          // ccName must be set on server.
          // ccLast4 must be set on server.
          // ccType must be set on server.
        });
        transaction.commit();

        record.on('didCreate', function() {
          // Transition to receipt page.
          submitButton.stop();
          if (that.get('content.bursary')) {
            that.get('controllers.registrationBursary').set('model', record);
            that.transitionToRoute('registration.bursary');
          } else {
            that.get('controllers.registrationReceipt').set('model', record);
            that.transitionToRoute('registration.receipt');
          }

          that.set('content', App.UserForm.create({}));
        });

        record.on('becameError', function() {
          that.set('serverError', true);
          that.trackError('Unknown', 'server', 'Unknown error, email: ' + content.get('email'));
          submitButton.stop();
        });

        record.on('becameInvalid', function() {
          var errors = record.get('errors');
          var errorCount = 0;

          for (var key in errors) {
            if (key === 'ccToken') {
              if (that.stripeError(errors[key][0])) {
                errorCount++;
              }
            } else if (errors.hasOwnProperty(key)) {
              content.set('errors.' + key, errors[key][0]);
              that.trackError(key, 'client', content.get(key));
              errorCount++;
            }
          }

          if (errorCount) {
            content.set('isValid', false);
          } else {
            content.set('serverError', true);
            that.trackError('Unknown', 'server', 'Unknown error, email: ' + content.get('email'));
          }
          submitButton.stop();
        });
      }
    };

    submitButton.start();
    content.set('isValid', true);
    content.set('serverError', false);

    var delayedHandleTransaction = function(status, response) {
      console.log('pre-delayed');
      console.log(status);
      console.log(response);
      window.setTimeout(function() {
        handleTransaction(status, response);
      }, 250);
    };

    if (content.get('bursary')) {
      delayedHandleTransaction(null, { id: 0 });
    } else {
      Stripe.card.createToken({
        name: content.get('ccName'),
        number: content.get('ccNumber'),
        cvc: content.get('ccCVC'),
        exp_month: content.get('ccExpirationMonth'),
        exp_year: content.get('ccExpirationYear')
      }, delayedHandleTransaction);
    }
  }
});

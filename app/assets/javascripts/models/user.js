App.User = DS.Model.extend({
  /* Meta Information */
  email: DS.attr('string'),
  verified: DS.attr('boolean'),
  createdAt: DS.attr('date'),
  confirmationToken: DS.attr('string'),
  ticketNumber: DS.attr('number'),

  /* Basic Information */
  firstName: DS.attr('string'),
  lastName: DS.attr('string'),
  gender: DS.attr('string'),
  phone: DS.attr('string'),
  residence: DS.attr('string'),
  discipline: DS.attr('string'),

  /* Package Information */
  packageId: DS.attr('number'),
  shirtSize: DS.attr('string'),
  groupId: DS.attr('number'),
  bursaryRequested: DS.attr('boolean'),
  bursaryChosen: DS.attr('boolean'),

  /* Emergency Contact Information */
  emergencyName: DS.attr('string'),
  emergencyEmail: DS.attr('string'),
  emergencyRelationship: DS.attr('string'),
  emergencyPhone: DS.attr('string'),

  /* Restrictions Information */
  restrictionsDietary: DS.attr('string'),
  restrictionsAccessibility: DS.attr('string'),
  restrictionsMisc: DS.attr('string'),

  /* Bursary Information */
  bursaryPaid: DS.attr('boolean'),
  bursaryOsap: DS.attr('boolean'),
  bursaryEngineeringMotivation: DS.attr('string'),
  bursaryFinancialReasoning: DS.attr('string'),

  /* Credit Card Information */
  chargeId: DS.attr('string'),    // always null (server side usage).
  ccToken: DS.attr('string'),     // only passed to server
  ccName: DS.attr('string'),      // passed back from server not stored
  ccLast4: DS.attr('number'),     // passed back from server not stored
  ccType: DS.attr('string')       // passed back from server not stored
});

App.User.attributes = [
  'email', 'verified', 'createdAt', 'confirmationToken', 'ticketNumber',
  'firstName', 'lastName', 'gender', 'phone', 'residence', 'discipline',
  'packageId', 'shirtSize', 'bursaryRequested', 'bursaryChosen',
  'emergencyName', 'emergencyEmail', 'emergencyRelationship', 'emergencyPhone',
  'restrictionsDietary', 'restrictionsAccessibility', 'restrictionsMisc',
  'bursaryPaid', 'bursaryOsap', 'bursaryEngineeringMotivation', 'bursaryFinancialReasoning'
];

App.UserFormEngineeringDisciplines = [
  '-',
  'Engineering Science',
  'Track One',
  'Chemical',
  'Civil',
  'Computer',
  'Electrical',
  'Industrial',
  'Material Science',
  'Mechanical',
  'Mineral'
];

App.UserFormGender = [
  '-',
  'Male',
  'Female'
];

App.UserFormShirtSize = [
  '-',
  'Small',
  'Medium',
  'Large',
  'Extra Large'
];

App.UserFormShirtHash = {
  'Small': 'S',
  'Medium': 'M',
  'Large': 'L',
  'Extra Large': 'XL'
};

App.UserForm = Ember.Object.extend(Ember.Validations.Mixin);
App.UserForm.reopen({
  validations: {
    email: {
      presence: true,
      length: { maximum: 50 },
      format: {
        'with': /.+@.+\..+/i,
        allowBlank: true
      }
    },

    firstName: {
      presence: true,
      length: { maximum: 50 }
    },

    lastName: {
      presence: true,
      length: { maximum: 50 }
    },

    gender: {
      inclusion: {
        'in': App.UserFormGender
      }
    },

    phone: {
      length: {
        allowBlank: true,
        maximum: 50
      },
      format: {
        allowBlank: true,
        'with': /^[^a-zA-Z]+$/
      }
    },

    residence: {
      length: {
        allowBlank: true,
        maximum: 50
      }
    },

    discipline: {
      presence: true,
      inclusion: {
        'in': App.UserFormEngineeringDisciplines
      },
      exclusion: {
        'in': ['-']
      }
    },

    shirtSize: {
      inclusion: {
        'in': App.UserFormShirtSize
      },
      exclusion: {
        'in': ['-']
      }
    },

    emergencyName: {
      presence: true,
      length: { maximum: 50 }
    },

    emergencyEmail: {
      presence: true,
      length: { maximum: 50 },
      format: {
        'with': /.+@.+\..+/i,
        allowBlank: true
      }
    },

    emergencyRelationship: {
      presence: true,
      length: { maximum: 50 }
    },

    emergencyPhone: {
      presence: true,
      length: { maximum: 50 },
      format: { 'with': /^[^a-zA-Z]+$/ }
    },

    restrictionsAccessibility: {
      length: {
        allowBlank: true,
        maximum: 2000
      }
    },

    restrictionsDietary: {
      length: {
        allowBlank: true,
        maximum: 2000
      }
    },

    restrictionsMisc: {
      length: {
        allowBlank: true,
        maximum: 2000
      }
    },

    bursaryEngineeringMotivation: {
      presence: {
        'if': function(object, validator) {
          return !!object.get('bursary');
        }
      },
      length: {
        maximum: 2000
      }
    },

    bursaryFinancialReasoning: {
      presence: {
        'if': function(object, validator) {
          return !!object.get('bursary');
        }
      },
      length: {
        maximum: 2000
      }
    },

    ccNumber: {
      absence: {
        unless: function(object, validator) {
          return Stripe.card.validateCardNumber(object.get('ccNumber'));
        }
      },
      presence: {
        unless: function(object, validator) {
          if (object.get('bursary')) {
            return true;
          }
          return Stripe.card.validateCardNumber(object.get('ccNumber'));
        }
      }
    },

    ccExpiration: {
      absence: {
        unless: function(object, validator) {
          var month = object.get('ccExpirationMonth');
          var year = object.get('ccExpirationYear');

          if (month && year) {
            month = parseInt(month, 10);
            year = parseInt(year, 10) + 2000;
            return Stripe.card.validateExpiry(month, year);
          }

          if (typeof month === 'undefined' || typeof year === 'undefined') {
            return true;
          } else {
            return false;
          }
        }
      },
      presence: {
        unless: function(object, validator) {
          if (object.get('bursary')) {
            return true;
          }

          var month = object.get('ccExpirationMonth');
          var year = object.get('ccExpirationYear');

          if (month && year) {
            month = parseInt(month, 10);
            year = parseInt(year, 10) + 2000;
            return Stripe.card.validateExpiry(month, year);
          }

          if (typeof month === 'undefined' || typeof year === 'undefined') {
            return true;
          } else {
            return false;
          }
        }
      }
    },

    ccName: {
      presence: {
        unless: function(object, validator) {
          return !!object.get('bursary');
        }
      },
      length: { maximum: 50 }
    },

    ccCVC: {
      absence: {
        unless: function(object, validator) {
          var cvc = object.get('ccCVC');
          return cvc && cvc.length > 0 && Stripe.card.validateCVC(cvc);
        }
      },
      presence: {
        unless: function(object, validator) {
          if (object.get('bursary')) {
            return true;
          }

          var cvc = object.get('ccCVC');
          return cvc && cvc.length > 0 && Stripe.card.validateCVC(cvc);
        }
      }
    }
  }
});

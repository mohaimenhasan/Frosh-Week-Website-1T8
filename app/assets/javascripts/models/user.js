App.User = DS.Model.extend({
  /* Meta Information */
  email: DS.attr('string'),
  verified: DS.attr('boolean'),
  createdAt: DS.attr('date'),

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
  group: DS.attr('string'),
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

  /* Credit Card Token (not stored server side) */
  ccToken: DS.attr('string')
});

App.UserForm = Ember.Object.extend(Ember.Validations.Mixin)
App.UserForm.reopen({
  validations: {
    email: {
      presence: true,
      length: { maximum: 50 },
      format: {
        with: /.+@.+\..+/i,
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

    phoneAreaCode: {
      length: {
        allowBlank: true,
        maximum: 10
      },
      numericality: {
        allowBlank: true,
        onlyInteger: true
      }
    },

    phoneStart: {
      length: {
        allowBlank: true,
        maximum: 10
      },
      numericality: {
        allowBlank: true,
        onlyInteger: true
      }
    },

    phoneEnd: {
      length: {
        allowBlank: true,
        maximum: 10
      },
      numericality: {
        allowBlank: true,
        onlyInteger: true
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
        // TODO(johnliu): define somewhere.
        in: [ 'Engineering Science',
              'Chemical',
              'Industrial',
              'Mechanical',
              'Mineral',
              'Civil',
              'Electrical',
              'Computer',
              'Material Science',
              'Track One' ]
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
        with: /.+@.+\..+/i,
        allowBlank: true
      }
    },

    emergencyRelationship: {
      presence: true,
      length: { maximum: 50 }
    },

    emergencyPhoneAreaCode: {
      length: {
        allowBlank: true,
        maximum: 10
      },
      numericality: {
        allowBlank: true,
        onlyInteger: true
      }
    },

    emergencyPhoneStart: {
      length: {
        allowBlank: true,
        maximum: 10
      },
      numericality: {
        allowBlank: true,
        onlyInteger: true
      }
    },

    emergencyPhoneEnd: {
      length: {
        allowBlank: true,
        maximum: 10
      },
      numericality: {
        allowBlank: true,
        onlyInteger: true
      }
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

    ccNumber: {
      absence: {
        unless: function(object, validator) {
          return Stripe.card.validateCardNumber(object.get('ccNumber'));
        }
      },
      presence: {
        unless: function(object, validator) {
          return Stripe.card.validateCardNumber(object.get('ccNumber'));
        }
      }
    },

    ccExpiration: {
      absence: {
        unless: function(object, validator) {
          var month = object.get('ccExpirationMonth');
          var year = object.get('ccExpirationYear');

          if (month || year) {
            month = parseInt(month, 10);
            year = parseInt(year, 10) + 2000;
            return Stripe.card.validateExpiry(month, year);
          }

          return false;
        }
      },
      presence: {
        unless: function(object, validator) {
          var month = object.get('ccExpirationMonth');
          var year = object.get('ccExpirationYear');

          if (month || year) {
            month = parseInt(month, 10);
            year = parseInt(year, 10) + 2000;
            return Stripe.card.validateExpiry(month, year);
          }

          return false;
        }
      }
    },

    ccName: {
      presence: true,
      length: { maximum: 50 }
    },

    ccCVC: {
      absence: {
        unless: function(object, validator) {
          var cvc = object.get('ccCVC');
          return cvc.length > 0 && Stripe.card.validateCVC(cvc);
        }
      },
      presence: {
        unless: function(object, validator) {
          var cvc = object.get('ccCVC');
          return cvc.length > 0 && Stripe.card.validateCVC(cvc);
        }
      }
    }
  }
});

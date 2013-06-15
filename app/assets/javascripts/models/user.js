App.User = DS.Model.extend(Ember.Validations.Mixin);
App.User.reopen({
  /* Meta Information */
  email: DS.attr('string'),
  verified: DS.attr('boolean'),
  creation: DS.attr('date'),

  /* Basic Information */
  firstName: DS.attr('string'),
  lastName: DS.attr('string'),
  phone: DS.attr('string'),
  residence: DS.attr('string'),
  discipline: DS.attr('string'),

  /* Package Information */
  packageType: DS.hasMany('App.Package'),
  shirtSize: DS.attr('string'),
  group: DS.attr('string'),
  bursary: DS.attr('boolean'),

  /* Emergency Contact Information */
  emergencyName: DS.attr('string'),
  emergencyEmail: DS.attr('string'),
  emergencyRelationship: DS.attr('string'),
  emergencyPhone: DS.attr('string'),

  /* Restrictions Information */
  restrictionsDietary: DS.attr('string'),
  restrictionsAccessibility: DS.attr('string'),
  restrictionsMisc: DS.attr('string'),

  /* Credit Card Information (not stored server side) */
  ccNumber: DS.attr('string'),
  ccExpiration: DS.attr('date'),
  ccName: DS.attr('string'),
  ccCVV: DS.attr('number')
});

App.UserRaw = App.User.extend({
  phoneAreaCode: DS.attr('number'),
  phoneStart: DS.attr('number'),
  phoneEnd: DS.attr('number'),

  emergencyPhoneAreaCode: DS.attr('number'),
  emergencyPhoneStart: DS.attr('number'),
  emergencyPhoneEnd: DS.attr('number'),

  shirtSizeS: DS.attr('boolean'),
  shirtSizeM: DS.attr('boolean'),
  shirtSizeL: DS.attr('boolean'),
  shirtSizeX: DS.attr('boolean'),

  ccExpirationMonth: DS.attr('number'),
  ccExpirationYear: DS.attr('number'),

  /* Client side validations */
  validations: {
    email: {
      presence: true,
      length: { maximum: 50 },
      format: {
        // TODO(johnliu): basic regex for email validation.
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
        // TODO(johnliu): basic email regex format.
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
      // TODO(johnliu): use stripe's validators.
      presence: true
    },

    ccExpirationMonth: {
      // TODO(johnliu): use stripe's validators.
      presence: true
    },

    ccExpirationYear: {
      // TODO(johnliu): use stripe's validators.
      presence: true
    },

    ccName: {
      // TODO(johnliu): use stripe's validators.
      presence: true
    },

    ccCVV: {
      // TODO(johnliu): use stripe's validators.
      presence: true
    }
  }
});

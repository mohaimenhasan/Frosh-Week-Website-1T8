App.Leedur = DS.Model.extend({
  /* Meta Information */
  email: DS.attr('string'),
  verified: DS.attr('boolean'),
  createdAt: DS.attr('date'),
  confirmationToken: DS.attr('string'),
  ticketNumber: DS.attr('number'),
  checkedIn: DS.attr('boolean'),

  /* Basic Information */
  firstName: DS.attr('string'),
  lastName: DS.attr('string'),
  gender: DS.attr('string'),
  phone: DS.attr('string'),
  year: DS.attr('string'),
  discipline: DS.attr('string'),

  /* Package Information */
  hhf_package_id: DS.attr('number'),
  bus: DS.attr('boolean'),

  /* Emergency Contact Information */
  emergencyName: DS.attr('string'),
  emergencyEmail: DS.attr('string'),
  emergencyRelationship: DS.attr('string'),
  emergencyPhone: DS.attr('string'),

  /* Restrictions Information */
  restrictionsDietary: DS.attr('string'),
  restrictionsMisc: DS.attr('string'),

  /* Credit Card Information */
  chargeId: DS.attr('string'),    // always null (server side usage).
  ccToken: DS.attr('string'),     // only passed to server
  ccName: DS.attr('string'),      // passed back from server not stored
  ccLast4: DS.attr('number'),     // passed back from server not stored
  ccType: DS.attr('string')       // passed back from server not stored
});

App.Leedur.Filter = Ember.Object.create({
  attributes: [
    'email',                  // string
    'verified',               // boolean
    'date',                   // date
    'ticket',                 // number
    'name',                   // string
    'gender',                 // string
    'phone',                  // string
    'discipline',             // string
    'package',                // string
    'bus',                    // boolean
    'year',                   // string
    'emergency_contact',      // string
    'emergency_email',        // string
    'emergency_relationship', // string
    'emergency_phone',        // string
    'restrictions',           // boolean
    'checked_in'              // boolean
  ],

  'email': function(model, query) {
    var email = model.get('email') || '';
    return email.toLowerCase().match(new RegExp(query.toLowerCase()));
  },

  'verified': function(model, query) {
    var verified = model.get('verified');
    var queryTrue = query.toLowerCase() === 'true';
    var queryFalse = query.toLowerCase() === 'false';

    return (verified && queryTrue) || (!verified && queryFalse);
  },

  'date': function(model, query) {
    // TODO(johnliu): implement
    return false;
  },

  'ticket': function(model, query) {
    var ticket = model.get('ticketNumber');
    var queryTicket = parseInt(query, 10);
    return ticket === queryTicket;
  },

  'name': function(model, query) {
    var fullName = (model.get('firstName') || '') + ' ' + (model.get('lastName') || '');
    return fullName.toLowerCase().match(new RegExp(query.toLowerCase()));
  },

  'gender': function(model, query) {
    var gender = model.get('gender') || '-';
    gender = gender.toLowerCase();

    var queryMale = query.toLowerCase() === 'male';
    var queryFemale = query.toLowerCase() === 'female';

    return (queryMale && gender === 'male') ||
      (queryFemale && gender === 'female') ||
      (!queryMale && !queryFemale && gender === '-');
  },

  'phone': function(model, query) {
    var phone = model.get('phone') || '';
    return phone.toLowerCase().match(new RegExp(query.toLowerCase()));
  },

  'discipline': function(model, query) {
    var discipline = model.get('discipline') || '';
    return discipline.toLowerCase().match(new RegExp(query.toLowerCase()));
  },

  'package': function(model, query) {
    var pkg = App.HhfPackage.find(model.get('hhf_package_id'));
    var searchable = (pkg.get('key') || '') + ' ' + (pkg.get('name') || '' ) + ' ' + (pkg.get('id') || '');
    return searchable.toLowerCase().match(new RegExp(query.toLowerCase()));
  },

  'bus': function(model, query) {
    var bus = model.get('bus');
    var queryTrue = query.toLowerCase() === 'true';
    var queryFalse = query.toLowerCase() === 'false';

    return (bus && queryTrue) || (!bus && queryFalse);
  },

  'year': function(model, query) {
    //TODO (Jason)
    return "";
  },

  
  'emergency_contact': function(model, query) {
    var emergency = model.get('emergencyName') || '';
    return emergency.toLowerCase().match(new RegExp(query.toLowerCase()));
  },

  'emergency_email': function(model, query) {
    var emergency = model.get('emergencyEmail') || '';
    return emergency.toLowerCase().match(new RegExp(query.toLowerCase()));
  },

  'emergency_relationship': function(model, query) {
    var emergency = model.get('emergencyRelationship') || '';
    return emergency.toLowerCase().match(new RegExp(query.toLowerCase()));
  },

  'emergency_phone': function(model, query) {
    var emergency = model.get('emergencyPhone') || '';
    return emergency.toLowerCase().match(new RegExp(query.toLowerCase()));
  },

  'restrictions': function(model, query) {
    var hasRestrictions = false;
    hasRestrictions = hasRestrictions || (model.get('restrictionsDietary') || '').length > 0;
    hasRestrictions = hasRestrictions || (model.get('restrictionsMisc') || '').length > 0;

    var queryTrue = query.toLowerCase() === 'true';
    var queryFalse = query.toLowerCase() === 'false';

    return (hasRestrictions && queryTrue) || (!hasRestrictions && queryFalse);
  },

  'checked_in': function(model, query) {
    var checkedIn = model.get('checkedIn');
    var queryTrue = query.toLowerCase() === 'true';
    var queryFalse = query.toLowerCase() === 'false';

    return (checkedIn && queryTrue) || (!checkedIn && queryFalse);
  }
});

App.LeedurFormEngineeringDisciplines = [
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

App.LeedurFormGender = [
  '-',
  'Male',
  'Female'
];


App.LeedurForm = Ember.Object.extend(Ember.Validations.Mixin);
App.LeedurForm.reopen({
  validations: {
    email: {
      presence: true,
      length: { maximum: 50 },
      format: {
        'with': /.+@mail\.utoronto\.ca/i,
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
        'in': App.LeedurFormGender
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

    year: {
      length: {
        allowBlank: true,
        maximum: 10
      }
    },

    discipline: {
      presence: true,
      inclusion: {
        'in': App.LeedurFormEngineeringDisciplines
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
          if (object.get('bursary') || object.get('isManual')) {
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
          if (object.get('bursary') || object.get('isManual')) {
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
          return !!object.get('bursary') || object.get('isManual');
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
          if (object.get('bursary') || object.get('isManual')) {
            return true;
          }

          var cvc = object.get('ccCVC');
          return cvc && cvc.length > 0 && Stripe.card.validateCVC(cvc);
        }
      }
    }
  }
});

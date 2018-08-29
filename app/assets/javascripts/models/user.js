App.User = DS.Model.extend({
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

  // /* Gender information */
  // genderOption: DS.attr('string'),
  // genderSpecify: DS.attr('string'),
  // gender: function(){
  //     if (genderOption === 'others' && genderSpecify != ''){
  //         return genderSpecify;
  //     }else{
  //         return genderOption;
  //     }
  // }
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
  /* Photo Consent */
  photoConsent: DS.attr('boolean'),
  tent: DS.attr('boolean'),

  /* Credit Card Information */
  chargeId: DS.attr('string'),    // always null (server side usage).
  ccToken: DS.attr('string'),     // only passed to server
  ccName: DS.attr('string'),      // passed back from server not stored
  ccLast4: DS.attr('number'),     // passed back from server not stored
  ccType: DS.attr('string')       // passed back from server not stored
});

App.User.Filter = Ember.Object.create({
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
    'group',                  // string
    'shirt',                  // string
    'photo_consent',          // boolean
    'tent',                   // boolean
    'bursary',                // boolean
    'bursary_accepted',       // boolean
    'bursary_osap',           // boolean
    'bursary_paid',           // boolean
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
    console.log(gender);

    return !(!gender || gender === '-');
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
    var pkg = App.Package.find(model.get('packageId'));
    var searchable = (pkg.get('key') || '') + ' ' + (pkg.get('name') || '' ) + ' ' + (pkg.get('id') || '');
    return searchable.toLowerCase().match(new RegExp(query.toLowerCase()));
  },

  'group': function(model, query) {
    var group = App.Group.find(model.get('groupId'));
    var searchable = (group.get('name') || '') + ' ' + (group.get('id') || '');
    return searchable.toLowerCase().match(new RegExp(query.toLowerCase()));
  },

  'shirt': function(model, query) {
    var shirt = model.get('shirtSize') || '';
    return shirt.toLowerCase().match(new RegExp(query.toLowerCase()));
  },

  'bursary': function(model, query) {
    var bursary = model.get('bursaryRequested');
    var queryTrue = query.toLowerCase() === 'true';
    var queryFalse = query.toLowerCase() === 'false';

    return (bursary && queryTrue) || (!bursary && queryFalse);
  },

  'bursary_accepted': function(model, query) {
    var bursary = model.get('bursaryChosen');
    var queryTrue = query.toLowerCase() === 'true';
    var queryFalse = query.toLowerCase() === 'false';

    return (bursary && queryTrue) || (!bursary && queryFalse);
  },
 'photo_consent': function(model, query) {
    var photo_consent = model.get('photoConsent');
    var queryTrue = query.toLowerCase() === 'true';
    var queryFalse = query.toLowerCase() === 'false';

    return (photo_consent && queryTrue) || (!photo_consent && queryFalse);
  },
  'tent': function(model, query) {
    var tent = model.get('tent');
    var queryTrue = query.toLowerCase() === 'true';
    var queryFalse = query.toLowerCase() === 'false';

    return (tent && queryTrue) || (!tent && queryFalse);
  },
  'bursary_osap': function(model, query) {
    var bursary = model.get('bursaryOsap');
    var queryTrue = query.toLowerCase() === 'true';
    var queryFalse = query.toLowerCase() === 'false';

    return (bursary && queryTrue) || (!bursary && queryFalse);
  },

  'bursary_paid': function(model, query) {
    var bursary = model.get('bursaryPaid');
    var queryTrue = query.toLowerCase() === 'true';
    var queryFalse = query.toLowerCase() === 'false';

    return (bursary && queryTrue) || (!bursary && queryFalse);
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
    hasRestrictions = hasRestrictions || (model.get('restrictionsAccessibility') || '').length > 0;
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
  'Female',
  'Others',
  'Do not wish to disclose'
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
          return !!object.get('bursary') && !object.get('isManual');
        }
      },
      length: {
        maximum: 2000
      }
    },

    bursaryFinancialReasoning: {
      presence: {
        'if': function(object, validator) {
          return !!object.get('bursary') && !object.get('isManual');
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

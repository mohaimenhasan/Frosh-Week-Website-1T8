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
    var userPhone =
      content.get('phoneAreaCode').toString() +
      content.get('phoneStart').toString() +
      content.get('phoneEnd').toString();

    var userShirtSize =
      content.get('shirtSizeS') == 'on' ? 'S' :
      content.get('shirtSizeM') == 'on' ? 'M' :
      content.get('shirtSizeL') == 'on' ? 'L' :
      content.get('shirtSizeX') == 'on' ? 'X' : 'M';

    var userEmergencyPhone =
      content.get('emergencyPhoneAreaCode').toString() +
      content.get('emergencyPhoneStart').toString() +
      content.get('emergencyPhoneEnd').toString();

    var userCCExpiration = new Date(content.get('ccExpirationYear') + 2000,
      content.get('ccExpirationMonth') - 1, 01);

    var transaction = this.get('store').transaction();
    var user = transaction.createRecord(App.User, {
      email: content.get('email'),
      verified: false,
      // creation date must be set on server.

      firstName: content.get('firstName'),
      lastName: content.get('lastName'),
      phone: userPhone,
      residence: content.get('residence'),
      discipline: content.get('discipline'),

      packageId: selectedPackage.get('id'),
      shirtSize: userShirtSize,
      // group must be set on the server.
      bursaryRequested: this.get('bursary') == 'on',
      // bursaryChosen must be set on the server.

      emergencyName: content.get('emergencyName'),
      emergencyEmail: content.get('emergencyEmail'),
      emergencyRelationship: content.get('emergencyRelationship'),
      emergencyPhone: userEmergencyPhone,

      restrictionsDietary: content.get('restrictionsDietary'),
      restrictionsAccessibility: content.get('restrictionsAccessibility'),
      restrictionsMisc: content.get('restrictionsMisc'),

      ccToken: null // TODO(johnliu): add stripe token.
    });
    transaction.commit();
  }
});

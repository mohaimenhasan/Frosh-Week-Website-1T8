App.User = DS.Model.extend({
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
  emergencyRelationship: DS.attr('string'),
  emergencyPhone: DS.attr('string'),

  /* Restrictions Information */
  restrictionsDietary: DS.attr('string'),
  restrictionsAccessibility: DS.attr('string'),
  restrictionsMisc: DS.attr('string')

  // TODO(johnliu): may need to add credit card info here.
});

Ember.Handlebars.registerBoundHelper('subset', function(users, group, options) {
  var gender = options.hash.gender;
  if (typeof gender === 'string') {
    gender = Ember.String.capitalize(gender.toLowerCase());
    if (gender !== 'Male' && gender !== 'Female') {
      gender = null;
    }
  } else {
    gender = null;
  }

  var filtered = users.filter(function(user) {
    var condition = true;
    if (condition && !Ember.isNone(gender)) {
      condition = user.get('gender') === gender;
    }

    if (condition && !Ember.isNone(group)) {
      condition = user.get('groupId').toString() === group.get('id');
    }

    return condition;
  });

  var percentage = (100 * filtered.get('length') / users.get('length')).toFixed(1);
  return filtered.get('length') + ' (' + percentage + '%)';
});

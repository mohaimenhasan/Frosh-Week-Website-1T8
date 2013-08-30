Ember.Handlebars.registerBoundHelper('timestamp', function(date, options) {
  var formatter = options.hash.format ? options.hash.format : 'hh:mm a MM-DD-YYYY';
  var parsed = moment(date);
  var formatted = parsed.format(formatter);

  return new Ember.String.htmlSafe(formatted);
});

Ember.Handlebars.registerBoundHelper('pluralize', function(count, options) {
  var singular = options.hash.string;
  var plural = options.hash.plural || singular + 's';
  return count === 1 ? singular : plural;
});

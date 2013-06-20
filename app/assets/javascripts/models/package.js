// TODO(johnliu): Implement cart.
App.Package = DS.Model.extend({
  name: DS.attr('string'),
  description: DS.attr('string'),
  price: DS.attr('number'),
  count: DS.attr('number'),
  max: DS.attr('number'),
  startDate: DS.attr('date'),
  endDate: DS.attr('date')
});

// TODO(johnliu): Implement cart.
App.Package = DS.Model.extend({
  key: DS.attr('string'),
  name: DS.attr('string'),
  price: DS.attr('number'),
  count: DS.attr('number'),
  startDate: DS.attr('date'),
  endDate: DS.attr('date')
});

App.HhfPackageItem = DS.Model.extend({
  key: DS.attr('string'),
  name: DS.attr('string'),
  description: DS.attr('string'),
  price: DS.attr('number'),
  count: DS.attr('number'),
  max: DS.attr('number'),
  left: DS.attr('number'),
  startDate: DS.attr('date'),
  endDate: DS.attr('date')
});

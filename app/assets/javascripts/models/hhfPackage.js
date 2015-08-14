App.HhfPackage = DS.Model.extend({
  key: DS.attr('string'),
  name: DS.attr('string'),
  price: DS.attr('number'),
  fweekbus: DS.attr('number'),
  leedurbus: DS.attr('number')
});

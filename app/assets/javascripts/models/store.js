App.StoreItem = DS.Model.extend({
  name: DS.attr('string'),
  description: DS.attr('string'),
  price: DS.attr('number'),
  count: DS.attr('number'),
  max: DS.attr('number'),
  startDate: DS.attr('date'),
  endDate: DS.attr('date'),

  cart: DS.belongsTo('App.Cart')
});

App.Cart = DS.Model.extend({
  items: DS.hasMany('App.StoreItem')
});

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

App.StoreItem.FIXTURES = [
  {
    id: 1,
    name: 'early-standalone',
    description: 'F!rosh Kit Early Bird Standalone',
    price: 95,
    count: 0,
    max: 1,
    startDate: new Date('05-01-2013'),
    endDate: new Date('09-01-2013'),
    cart: null
  },
  {
    id: 2,
    name: 'early-farm',
    description: 'F!rosh Kit Early Bird + Hart House Farm Package',
    price: 120,
    count: 0,
    max: 1,
    startDate: new Date('05-01-2013'),
    endDate: new Date('09-01-2013'),
    cart: null
  },
  {
    id: 3,
    name: 'early-commuter',
    description: 'F!rosh Kit Early Bird + Commuter Program Package',
    price: 180,
    count: 0,
    max: 1,
    startDate: new Date('05-01-2013'),
    endDate: new Date('09-01-2013'),
    cart: null
  },
  {
    id: 4,
    name: 'early-all',
    description: 'F!rosh Kit Early Bird + Hart House Farm + Commuter Program Package',
    price: 205,
    count: 0,
    max: 1,
    startDate: new Date('05-01-2013'),
    endDate: new Date('09-01-2013'),
    cart: null
  }
];

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

App.Package.FIXTURES = [
  {
    id: 1,
    name: 'test-standalone',
    description: 'F!rosh Kit Early Bird Standalone',
    price: 95,
    count: 0,
    max: 1,
    startDate: new Date('05-01-2013'),
    endDate: new Date('09-01-2013')
  },
  {
    id: 2,
    name: 'test-farm',
    description: 'F!rosh Kit Early Bird + Hart House Farm Package',
    price: 120,
    count: 0,
    max: 1,
    startDate: new Date('05-01-2013'),
    endDate: new Date('09-01-2013')
  },
  {
    id: 3,
    name: 'test-commuter',
    description: 'F!rosh Kit Early Bird + Commuter Program Package',
    price: 180,
    count: 0,
    max: 1,
    startDate: new Date('05-01-2013'),
    endDate: new Date('09-01-2013')
  },
  {
    id: 4,
    name: 'test-all',
    description: 'F!rosh Kit Early Bird + Hart House Farm + Commuter Program Package',
    price: 205,
    count: 0,
    max: 1,
    startDate: new Date('05-01-2013'),
    endDate: new Date('09-01-2013')
  }
];

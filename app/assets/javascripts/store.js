App.Store = DS.Store.extend({
  adapter: 'DS.RESTAdapter',
  init: function() {
    this._super();
    this.loadMany(App.Package, App.Package.FIXTURES);
  }
});

DS.RESTAdapter.reopen({
  namespace: 'api'
});

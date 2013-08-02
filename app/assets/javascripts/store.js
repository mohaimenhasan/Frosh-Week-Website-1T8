App.Store = DS.Store.extend({
  adapter: 'DS.RESTAdapter'
});

DS.RESTAdapter.reopen({
  namespace: 'api'
});

DS.RESTAdapter.registerTransform('array', {
  serialize: function(value) {
    if (Ember.typeOf(value) === 'array') {
      return value;
    }
    return [];
  },

  deserialize: function(value) {
    return value;
  }
});

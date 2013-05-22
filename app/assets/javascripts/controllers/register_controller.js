App.RegisterIndexController = Ember.Controller.extend({
  selected: null,
  select: function(context) {
    selected = context;
    this.transitionToRoute('register.item', context);
  }
});

App.RegisterItemController = Ember.Controller.extend({
  cancel: function() {
    this.transitionToRoute('register.index');
  }
});

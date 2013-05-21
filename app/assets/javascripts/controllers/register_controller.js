App.RegisterIndexController = Ember.Controller.extend({
  selected: null,
  select: function(context) {
    selected = context;
    this.transitionToRoute('register.item', context);
  }
});

App.ApplicationView = Ember.View.extend({
});

App.ReactiveTextField = Ember.TextField.extend({
  keyUp: function(event) {
    var action = this.get('action');
    if (action && this.get('onEvent') === 'keyUp') {
      var timeoutId = this.get('timeoutId');
      if (!Ember.isNone(timeoutId)) {
        window.clearTimeout(timeoutId);
      }

      var that = this;
      this.set('timeoutId', window.setTimeout(function() {
        that.get('controller').send(action, that.get('value'), that);
      }, 100));

      if (!this.get('bubbles')) {
        event.stopPropagation();
      }
    }
  }
});

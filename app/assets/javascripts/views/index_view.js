App.IndexVideoView = Ember.View.extend({
  templateName: 'index_video',

  classNames: ['home-video'],

  classNameBindings: ['videoShowing:showing:hidden'],

  videoShowing: function(key, value) {
    if (arguments.length === 1) {
      return this.get('controller.videoShowing');
    } else {
      this.set('controller.videoShowing', value);
      return value;
    }
  }.property('controller.videoShowing'),

  canPlay: function() {
    // We need this because iOS doesn't support autoplaying.
    return navigator.userAgent.match(/(iPad|iPhone|iPod)/g) ? false : true;
  },

  didInsertElement: function() {
    this._super.apply(this, arguments);
    var that = this;

    var loadedWrapper = function() {
      that.onPlayerLoaded.apply(that, arguments);
    };

    var stateChangeWrapper = function() {
      that.onPlayerStateChanged.apply(that, arguments);
    };

    window.onYouTubeIframeAPIReady = function() {
      that.set('videoPlayer', new YT.Player('video-player', {
        events: {
          'onReady': loadedWrapper,
          'onStateChange': stateChangeWrapper
        }
      }));
    };
  },

  onPlayerLoaded: function() {
    if (this.canPlay() && this.get('videoShowing')) {
      var player = this.get('videoPlayer');
      try {
        player.setPlaybackQuality('hd720');
        player.playVideo();
      } catch (ignore) { }
    }
  },

  onPlayerStateChanged: function(event) {
    if (event.data === YT.PlayerState.ENDED) {
      this.set('videoShowing', false);
    }
  },

  onPlayerChangeVisibility: function() {
    var player = this.get('videoPlayer');
    if (this.get('videoShowing')) {
      this.$().attr({ tabIndex: 1 });
      this.$().focus();

      if (this.canPlay() && !Ember.isNone(player)) {
        try {
          player.playVideo();
        } catch (ignore) { }
      }
    } else {
      if (!Ember.isNone(player)) {
        try {
          player.pauseVideo();
          player.seekTo(0, true);
        } catch (ignore) { }
      }
    }

  }.observes('videoShowing'),

  click: function() {
    this.set('videoShowing', false);
  },

  keyUp: function(event) {
    if (event.keyCode === 27) {
      this.set('videoShowing', false);
    }
  }
});
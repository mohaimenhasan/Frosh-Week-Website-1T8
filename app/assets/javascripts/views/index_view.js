App.IndexVideoView = Ember.View.extend({
  templateName: 'index_video',

  classNames: ['home-video'],

  classNameBindings: ['videoShowing:showing:hidden'],

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
        height: '450',
        width: '800',
        videoId: 'S5VsfvfPdx4',
        events: {
          'onReady': loadedWrapper,
          'onStateChange': stateChangeWrapper
        }
      }));
    };
  },

  videoShowing: function(key, value) {
    if (arguments.length === 1) {
      return this.get('controller.videoShowing');
    } else {
      this.set('controller.videoShowing', value);
      return value;
    }
  }.property('controller.videoShowing'),

  onPlayerLoaded: function() {
    if (this.get('videoShowing')) {
      var player = this.get('videoPlayer');
      player.setPlaybackQuality('hd720');
      player.playVideo();
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

      if (!Ember.isNone(player)) {
        try {
          player.seekTo(0, true);
        } catch (ignore) {
        }

        player.playVideo();
      }
    } else {
      if (!Ember.isNone(player)) {
        player.pauseVideo();
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
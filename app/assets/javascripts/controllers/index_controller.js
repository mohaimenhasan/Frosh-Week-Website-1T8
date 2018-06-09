App.IndexController = Ember.Controller.extend({
  daysRemaining: function() {
    var end = new Date('Sept 02 2018 23:59:59 EDT');
    var current = new Date();

    var days = (end - current) / 1000 / 60 / 60 / 24;
    days = days.toFixed(0);
    if(days > 0) {
      return days
    }
    else {
      return 0;
    }
  }.property(),

  hasStarted: function() {
    return this.get('daysRemaining') <= 0;
  }.property('daysRemaining'),

  showVideo: function(event) {
    this.set('videoShowing', true);
    return false;
  },

  hidingPop: true,

  openPop: function() {
    Ember.Logger.log("Opening pop");
    this.set("hidingPop", false);
  },

  closePop: function() {
    console.log("Closing pop");
    this.set("hidingPop", true);
  },

  closeBlack: function() {
    var that = this;
    console.log("Here", this.target);

  },

  name: "",
  email: "",
  timestamp: 0,
  alreadyDisable: function(){
    return Ember.isEmpty(this.get("name")) ||
           Ember.isEmpty(this.get("email"));
  }.property("name", "email"),

  alreadyAsking: true,

  submit: function(){
    console.log("Submitting");
    //Make sure all fields are filled up
    if(!this.get("alreadyDisable")){
      //Clear out all error messages first
      $("#spam_message").fadeOut("fast");
      $("#send_error_msg").fadeOut("fast");
      $("#error_message").fadeOut("fast");
      /************ Validate email *****************/
      var email = this.get("email");
      //Reference: (different from backend validation) http://emailregex.com/
      var valid = email.match(/^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i);
      if(!valid){
       $("#error_message").fadeIn("slow");
       this.set("alreadyAsking", true);
      }
      //Posting to google sheet hack: will produce cross-site error
      else {
        //No spamming
        var current = Date.now() / 1000 | 0;
        var past = this.get("timestamp");
        if (current < past + 5) {
          //if more than 5 sec, consider spam
          $("#spam_message").fadeIn("slow");
          return;
        }
        else {
          this.set("timestamp", current); //renew timestamp
        }


        var that = this;
        $.ajax({
          url: "https://docs.google.com/forms/d/1TLfX4Oc45AU7EjWZIQK5TGmiQMxmogrvkzmYuiPBdQQ/formResponse",
          data: {"entry.2116346682" : that.get("name"),
                       "entry.147362869" : that.get("email")},
          type: "POST",
          dataType: "xml",
          statusCode: {
            0: function (){
            //Success
              that.set("alreadyAsking", false);

            },
            200: function (){
             //Success
               that.set("alreadyAsking", false);

            },
            400: function () {
              $("#send_error_msg").fadeIn("slow");
              this.set("alreadyAsking", true);
            },
            500: function () {
              $("#send_error_msg").fadeIn("slow");
              this.set("alreadyAsking", true);
            },

            }
        });

      }
    }


  }

});

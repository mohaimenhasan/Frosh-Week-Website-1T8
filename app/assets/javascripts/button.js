App.PopController = Ember.Controller.extend({
  name: "",
  email: "",
  timestamp: 0,
  alreadyDisable: function(){
    return Ember.isEmpty(this.get("name")) || 
           Ember.isEmpty(this.get("email"));
  }.property("name", "email"),

  alreadyAsking: true,
    
  submit_new: function(){
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
      
       
        var that = this
        $.ajax({
          url: "https://docs/google.com/forms/d/1TLfX4Oc45AU7EjWZIQK5TGmiQMxmogrvkzmYuiPBdQQ",
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

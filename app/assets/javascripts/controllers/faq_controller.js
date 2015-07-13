App.FaqController = Ember.Controller.extend({
  name: "",
  email: "",
  question: "",
  timestamp: 0,
  isDisable: function(){
    return Ember.isEmpty(this.get("name")) || 
           Ember.isEmpty(this.get("email")) ||
           Ember.isEmpty(this.get("question"));
  }.property("name", "email", "question"),

  isAsking: true,
    
  submit: function(){
    //No spamming
    var current = Date.now() / 1000 | 0;
    var past = this.get("timestamp");
    if (current < past + 5) {
      //if more than 3 sec, consider spam
      $("#spam_message").fadeIn("slow");
      return;   
    }
    else {
      $("#spam_message").fadeOut("slow");
      this.set("timestamp", current); //renew timestamp   
    }
      
    //Validation
    if(!this.get("isDisable")){
      /************ Validate email *****************/
      var email = this.get("email");
      //Reference: (different from backend validation) http://emailregex.com/
      var valid = email.match(/^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i);
      if(!valid){
        $("#error_message").fadeIn("slow");
        this.set("isAsking", true);
      }
      //Posting to google sheet
      else {
        $("#error_message").fadeOut("slow");
        this.set("isAsking", false);
        $.ajax({
          url: "https://docs.google.com/forms/d/12w17v5mgY0wSYrCk-eshsTja6YstyuF5s4hcqM7aIz0/formResponse",
          data: {"entry.1580877580" : this.get("name"), 
                       "entry.421886191" : this.get("email"), 
                       "entry.811584276": this.get("question") },
          type: "POST",
          dataType: "xml",
          statusCode: {
            0: function (){
              //Success 
            },
            200: function (){
            //Success 
            }
          }
        });

      }
    }
      
      
  }
  
});
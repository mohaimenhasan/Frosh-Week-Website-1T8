App.VolunteerController = Ember.Controller.extend({
  name: "",
  email: "",
  year: "",
  selected: {'leedur':false, 'hhf':false},
  timestamp: 0,
  isDisable: function(){
    return Ember.isEmpty(this.get("name")) || 
           Ember.isEmpty(this.get("email")) || 
           Ember.isEmpty(this.get("year"));
  }.property("name", "email", "year"),

  isAsking: true,
  

  submit: function(){
    //Make sure all fields are filled up

    if(!this.get("isDisable")){
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
        this.set("isAsking", true);
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
        
        //FIXME: Should use Ember features
        var checkList = "";
        $('input[type=checkbox]').each(function(){
          Ember.Logger.log(this.id, this);
          checkList += (this.checked? this.id : "") + " ";
        });
        Ember.Logger.log(checkList);
       /*
        var that = this
        $.ajax({
          url: "https://docs.google.com/forms/d/12w17v5mgY0wSYrCk-eshsTja6YstyuF5s4hcqM7aIz0/formResponse",
          data: {"entry.1580877580" : that.get("name"), 
                       "entry.421886191" : that.get("email"), 
                       "entry.811584276": that.get("question") },
          type: "POST",
          dataType: "xml",
          statusCode: {
            0: function (){
            //Success
              that.set("isAsking", false);
            },
            200: function (){
            //Success 
              that.set("isAsking", false);
            },
            400: function () {
              $("#send_error_msg").fadeIn("slow");
              this.set("isAsking", true); 
            },
            500: function () {
              $("#send_error_msg").fadeIn("slow");
              this.set("isAsking", true); 
            },   
            
          }
        });
*/    this.set("isAsking", false); 
      }
    }
      
      
  }
  
});

App.VolunteerFormEngineeringDisciplines = [
  'Engineering Science',
  'Track One',
  'Chemical',
  'Civil',
  'Computer',
  'Electrical',
  'Industrial',
  'Material Science',
  'Mechanical',
  'Mineral'
];
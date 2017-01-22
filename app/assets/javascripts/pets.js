/* global $ */
//Document ready.
$(document).on('turbolinks:load', function(){
    var theForm = $('#pet_form');
    var submitBtn = $('#form-signup-btn');
    
    submitBtn.click(function(event){
        //prevent default submission behavior.
        event.preventDefault();
        submitBtn.val("Processing").prop('disabled', true);
        
        //Collect the form fields.
        var hp = $('#pet_hp').val(),
            strength = $('#pet_strength').val(),
            defence = $('#pet_defence').val();
            
        hp = parseInt(hp);
        strength = parseInt(strength);
        defence = parseInt(defence);
            
        console.log(hp);
        console.log(strength);
        console.log(defence);
        console.log(theForm);
        
        //Verify the stats    
        if(hp == undefined) {
            hp = 0;
        }
        
        if(strength == undefined) {
            strength = 0;
        }
        
        if(defence == undefined) {
            defence = 0;
        }
         
        //Add up the stats   
        var hsd = hp + strength + defence;
        
        //Append to form
        theForm.append( $('<input type="hidden" name="pet[hsd]">').val(hsd) );
        
        //Submit the form
        theForm.submit();
        
    });
    
    return false;
});
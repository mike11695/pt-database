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
            defence = $('#pet_defence').val(),
            name = $('#pet_name').val(),
            uft = $('#pet_uft').is(':checked'),
            ufa = $('#pet_ufa').is(':checked');
            
        var error = false;
        
        if(name.length > 20) {
            error = true;
            alert('Pet name can not exceed 20 characters.');
        } else if(/\s/.test(name)) {
            // It has any kind of whitespace
            error = true;
            alert('Pet name cannot have spaces');
        }
        
        if(uft == false && ufa == false) {
            error = true;
            alert('You must select UFT or UFA');
        }
        
        
        if (error) {
            submitBtn.prop('disabled', false).val("Submit Pet");
        }
        else {
            //Submit the form
            theForm.submit();
        }
    });
    
    return false;
    
});
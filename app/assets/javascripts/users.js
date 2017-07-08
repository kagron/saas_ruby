/* global $ */
/* global Stripe */
$(document).on('turbolinks:load',function(){
  var form = $('#pro_form'),
  button = $('#form-signup-btn');
  //Set Stripe public key
  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
  
  // When user clicks form button, prevent default behavior
  button.click(function(event){
    event.preventDefault();
    button.val("Processing").prop('disabled', true);
    
    // Collect credit card info
    var ccNum = $('#card_number').val(),
    cvcNum = $('#card_code').val(),
    expMonth = $('#card_month').val(),
    expYear = $('#card_year').val();
    
    // Validate the info using Stripe
    var error = false;
    //Validate Credit Card number
    if(!Stripe.card.validateCardNumber(ccNum)){
      error = true;
      alert('The credit card number appears to be invalid');
    }
    // Validate CVC number
    if(!Stripe.card.validateCVC(cvcNum)){
      error = true;
      alert('The CVC number appears to be invalid');
    }
    // Validate expiration date
    if(!Stripe.card.validateExpiry(expMonth, expYear)){
      error = true;
      alert('The expiration date appears to be invalid');
    }
    // If error is true
    if(error) { 
      button.prop('disabled', false).val("Sign Up");
    } else {
      // Send info to Stripe
      Stripe.createToken({
        number: ccNum,
        cvc: cvcNum,
        exp_month: expMonth,
        exp_year: expYear
      }, stripeResponseHandler);
    }
    
    return false;
  });


  // Stripe will return a card token
  function stripeResponseHandler(status, response){
    var token = response.id;
    
    // Inject the token into the hidden field 
    form.append($('<input type="hidden" name="user[stripe_card_token]">').val(token) );
    
    // Submit the form
    form.get(0).submit();
  }
});
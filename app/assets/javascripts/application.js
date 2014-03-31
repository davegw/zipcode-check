// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(function() {
  $("#new_location_js_container #new_location").validate({
    debug: true,
    rules: {
      "location[address]": {required: true},
      "location[city]": {required: true},
      "location[state]": {required: true, min: 2, max: 2},
      "location[zipcode]": {required: true, digits: true, min: 5, max: 5}
    },
    messages : {
      'location[state]' : {
        min : "State postal code must be 2 letters.",
        max : "State postal code must be 2 letters."
      },
      'location[zipcode]' : {
        min : "Zip code must be 5 digits.",
        max : "Zip code must be 5 digits."
      }
    }
  });
});

$(function() {
  $('#new_location_js_container .submit input[type="submit"]').click(function(e) {
    e.preventDefault();
    $('#errors_container').empty();
    var address = $('#location_address').val();
    var city = $('#location_city').val();
    var state = $('#location_state').val();
    var zipcode = $('#location_zipcode').val();
    $.ajax({
      url: '/location/request',
      data: {'address': address, 'city': city, 'state': state, 'zipcode': zipcode},
      type: 'GET',
      success: function(response) {
        if (response.success) {
          $('#new_location_js_container').load('/location/success', { "result" : response.query, "location" : response.location_id})
        }
        else if (response.errors.length > 0) {
          var i;
          for (i=0; i<response.errors.length; ++i) {
            $('#errors_container').append("<li class='red_text'>"+response.errors[i]+"</li>");
          }
        }
        else {
          $('#errors_container').append("<h3 id='no_zip_match'>"+response.zip_errors+"</li");
        }
      }
    });
  });
});

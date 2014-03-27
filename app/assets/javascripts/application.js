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

// $(function() {
//   $('h1').click(function() {
//     $(this).hide();
//   });
// });

// $(function() {
//   $("#new_user").validate({
//     debug: true,
//     rules: {
//       "user[email]": {required: true, email: true, remote: "/users/check_email"},
//       "user[name]": {required: true}
//     }
//   });
// });

// $(function() {
//   $('.submit input[type="submit"]').click(function(e) {
//     e.preventDefault();
//     // var address = $('.address').val();
//     // var city = $('.city').val();
//     // var state = $('.state').val();
//     $.ajax({
//       url: 'https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&sensor=false&key=AIzaSyBHB-4XsqFcIYYhid36PjMj5YJwkiFYy7Y',
//       // url: 'https://maps.googleapis.com/maps/api/geocode/json?address=' + address + ',' + city + ',' + state + '&sensor=true&key=AIzaSyBHB-4XsqFcIYYhid36PjMj5YJwkiFYy7Y/',
//       type: 'GET',
//       success: function(response) {
//         if (response.success) {
//           $('#location_form').hide();
//         }
//         else {
//           alert(response);
//           $('h1').hide();
//         }
//       }
//     });
//   });
// });

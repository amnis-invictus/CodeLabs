//= require jquery3
//= require popper
//= require bootstrap
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require toastr/toastr
//= require cocoon
//= require sweetalert2
//= require sweet-alert2-rails
//= require bootstrap-tagsinput.min.js
//= require typeahead.min.js
//= require ckeditor.js
//= require_tree .

$(function () {
  $('input[readonly]').on('focus', function () { $(this).blur(); });

  $('[data-toggle="tooltip"]').tooltip();
});

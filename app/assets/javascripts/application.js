//= require jquery3
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require toastr/toastr
//= require bootstrap.min.js
//= require bootstrap-tagsinput.min.js
//= require_tree .

$("input[readonly]").on('focus', () => {
    $(this).blur();
});

$('[data-toggle="tooltip"]').tooltip();
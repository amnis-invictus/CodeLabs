//= require jquery3
//= require popper
//= require bootstrap
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require toastr/toastr
//= require bootstrap-tagsinput.min.js
//= require cocoon
//= require sweetalert2
//= require sweet-alert2-rails
//= require_tree .

$(function () {
    $("input[readonly]").on('focus', () => {
        $(this).blur();
    });

    $('[data-toggle="tooltip"]').tooltip();
});

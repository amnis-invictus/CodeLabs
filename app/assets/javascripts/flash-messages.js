toastr.options.closeButton = true;

toastr.options.timeOut = 1500;

toastr.recaptcha_error = toastr.error;

document.addEventListener('turbolinks:load', function () {
  $('body').data('flash').forEach(function (m) { toastr[m[0]](m[1]); });
});

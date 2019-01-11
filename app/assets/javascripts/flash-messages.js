Object.assign(toastr.options, { closeButton: true, timeOut: 1500 });

document.addEventListener('turbolinks:load', function () {
  $('body').data('flash').forEach(function (m) { toastr[m[0]](m[1]); });
});

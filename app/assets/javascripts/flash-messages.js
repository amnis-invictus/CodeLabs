toastr.options.closeButton = true;

toastr.options.timeOut = 1500;

document.addEventListener('turbolinks:load', function () {
    var messages = $('body').data('flash');

    messages.forEach(function (m) {
        toastr[m.type](m.message)
    });
});
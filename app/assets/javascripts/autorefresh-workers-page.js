(function () {
  var regex = /^\/[a-z][a-z]\/workers\/?$/i;

  var handle = null;

  function refresh() {
    Turbolinks.visit(window.location.toString());
  }

  document.addEventListener('turbolinks:load', function () {
    clearTimeout(handle)

    if (regex.test(window.location.pathname))
      handle = setTimeout(refresh, 5000);
  });
})();

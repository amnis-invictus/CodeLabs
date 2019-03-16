(function () {
  var regex = /^\/[a-z][a-z]\/problems\/[\-a-zA-Z0-9]+\/?$/i;

  document.addEventListener('turbolinks:load', function () {
    if (regex.test(window.location.pathname))
      MathJax.Hub.Queue(['Typeset', MathJax.Hub]);
  });
})();

$(function () { MathJax.Hub.Config({ skipStartupTypeset: true }); })

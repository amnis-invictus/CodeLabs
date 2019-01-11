(function () {
  var nonce = undefined;

  document.addEventListener('turbolinks:load', function () {
    if (nonce === undefined)
      nonce = $('meta[name="csp-nonce"]').prop('content');
    else
      $('meta[name="csp-nonce"]').prop('content', nonce);
  });
})();

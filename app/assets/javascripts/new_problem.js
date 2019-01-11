(function () {
  function newProblem() {
    var form = $(this);

    form.find(':submit').on('click', function () {
      this.disabled = true;

      $('#process-problem-archive-log').html('');

      form.submit();
    });
  }

  jQuery.fn.extend({ newProblem: function () { return this.each(newProblem); } });

  document.addEventListener('turbolinks:load', function () { $('form#new_problem').newProblem(); });
})();

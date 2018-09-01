jQuery.fn.extend({
  newProblem: function () {
    return this.each(function () {
      const form = $(this)

      form.find(':submit').on('click', function () {
        this.disabled = true

        $('#process-problem-archive-log').html('')

        form.submit()
      })
    })
  }
})

document.addEventListener('turbolinks:load', () => $('form#new_problem').newProblem())

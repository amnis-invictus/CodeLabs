jQuery.fn.extend({
  processProblemArchiveLog: function () {
    return this.each(function () {
      const block = $(this)

      App.processProblemArchiveSubscription = App.cable.subscriptions.create(
        { channel: 'ProcessProblemArchiveChannel', id: block.data('channel-id') },
        {
          received: data => {
            block.append(`<p>${data}</p>`)

            if (data == 'Done.') {
              $('form#new_problem :submit').prop('disabled', false)
            }
          }
        }
      )
    })
  }
})

document.addEventListener('turbolinks:load', () => $('#process-problem-archive-log').processProblemArchiveLog())

document.addEventListener('turbolinks:before-render', () => {
  if (App.processProblemArchiveSubscription) {
    App.processProblemArchiveSubscription.unsubscribe()

    App.processProblemArchiveSubscription = undefined
  }
})

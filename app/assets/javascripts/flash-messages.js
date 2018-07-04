Object.assign(toastr.options, { closeButton: true, timeOut: 1500 })

document.addEventListener('turbolinks:load', () => {
  const messages = $('body').data('flash')

  messages.forEach(([type, message]) => toastr[type](message))
})

jQuery.fn.extend({
  datahref: function () {
    return this.each(function () {
      const block = $(this),
        url = block.data('href'),
        target = block.data('target') || '_self'

      block.click(() => window.open(url, target))
    })
  }
})

document.addEventListener('turbolinks:load', () => $('[data-href]').datahref())

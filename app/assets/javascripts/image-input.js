jQuery.fn.extend({
  imageInput: function () {
    return this.each(function () {
      const block = $(this)

      const input = block.children('input')

      const image = block.children('img')

      block.children('.image-input__prompt').click(() => input.click())

      input.change(() => {
        const files = input.prop('files')

        if (files && files[0]) {
          const reader = new FileReader()

          reader.onload = (e) => image.attr('src', e.target.result)

          reader.readAsDataURL(files[0])
        }
      })
    })
  }
})

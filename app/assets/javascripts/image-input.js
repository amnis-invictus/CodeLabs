jQuery.fn.extend({
  imageInput: function () {
    return this.each(function () {
        var block = $(this);

        var input = block.children('input');

        var image = block.children('img');

        block.children('.image-input__prompt').click(function () {
            input.click()
        });

      input.change(function () {
          var files = input.prop('files');

        if (files && files[0]) {
            const reader = new FileReader();

            reader.onload = function (e) {
                image.attr('src', e.target.result)
            };

          reader.readAsDataURL(files[0])
        }
      })
    })
  }
});

document.addEventListener('turbolinks:load', function () {
    $('.image-input').imageInput()
});

'use strict';

(function () {
  var defaultOptions = {
    url: '/avatar',
    cache: false,
    contentType: false,
    processData: false,
    method: 'POST',
    dataType: 'json'
  }

  function imageInput() {
    var block = $(this);

    var input = block.children('input');

    var image = block.children('img');

    block.children('.image-input__prompt').click(function () {
      input.click();
    });

    function success(data) {
      image.attr('src', data.url);
    }

    input.change(function () {
      var files = input.prop('files');

      var data = new FormData();

      data.append('avatar[file]', files && files[0]);

      $.ajax(Object.assign({}, defaultOptions, { data: data, success: success }));
    });
  }

  jQuery.fn.extend({
    imageInput: function () {
      return this.each(imageInput);
    }
  });

  document.addEventListener('turbolinks:load', function () {
    $('.image-input').imageInput();
  });
})()

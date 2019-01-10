'use strict';

(function () {
  function replaceTextareas() {
    $('[data-textarea="ckeditor"]').each(function () {
      ClassicEditor.create(this).catch(function (err) { console.error(err.stack) });

      $(this).attr('data-textarea', 'replaced');
    })
  }

  $(document).on('turbolinks:load', replaceTextareas);

  $(document).on('cocoon:after-insert', replaceTextareas);
})();

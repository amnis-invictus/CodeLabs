(function () {
  function replaceTextareas() {
    const ckConfig = {
      htmlSupport: {
        allow: [
          {
            name: /.*/,
            classes: true,
          }
        ],
      }
    }

    $('[data-textarea="ckeditor"]').each(function () {
      ClassicEditor.create(this, ckConfig).catch(function (err) { console.error(err.stack) });

      $(this).attr('data-textarea', 'replaced');
    })
  }

  $(document).on('turbolinks:load', replaceTextareas);

  $(document).on('cocoon:after-insert', replaceTextareas);
})();

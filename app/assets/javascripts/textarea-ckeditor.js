'use strict';

function replaceTextareas() {
  $('[data-textarea="ckeditor"]').each(function () {
    CKEDITOR.replace($(this).attr('id'));
    $(this).attr('data-textarea', 'replaced');
  })
}

$(document).on('turbolinks:load', replaceTextareas);
$(document).on('cocoon:after-insert', replaceTextareas);

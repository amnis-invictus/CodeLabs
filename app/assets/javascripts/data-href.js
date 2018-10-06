'use strict';

jQuery.fn.extend({
    datahref: function datahref() {
        return this.each(function () {
            var block = $(this);

            var url = block.data('href');

            var target = block.data('target') || '_self';

            block.click(function () {
                window.open(url, target);
            });
        });
    }
});

document.addEventListener('turbolinks:load', function () {
    $('[data-href]').datahref();
});
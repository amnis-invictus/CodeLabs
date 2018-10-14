'use strict';

jQuery.fn.extend({
    newProblem: function newProblem() {
        return this.each(function () {
            var form = $(this);

            form.find(':submit').on('click', function () {
                this.disabled = true;

                $('#process-problem-archive-log').html('');

                form.submit();
            });
        });
    }
});

document.addEventListener('turbolinks:load', function () {
    $('form#new_problem').newProblem();
});
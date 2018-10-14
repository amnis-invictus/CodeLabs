'use strict';

jQuery.fn.extend({
    processProblemArchiveLog: function processProblemArchiveLog() {
        return this.each(function () {
            var block = $(this);

            App.processProblemArchiveSubscription = App.cable.subscriptions.create({
                channel: 'ProcessProblemArchiveChannel',
                id: block.data('channel-id')
            }, {
                received: function received(data) {
                    block.append('<p>' + data + '</p>');

                    if (data === 'Done.') {
                        $('form#new_problem :submit').prop('disabled', false);
                    }
                }
            });
        });
    }
});

document.addEventListener('turbolinks:load', function () {
    $('#process-problem-archive-log').processProblemArchiveLog();
});

document.addEventListener('turbolinks:before-render', function () {
    if (App.processProblemArchiveSubscription) {
        App.processProblemArchiveSubscription.unsubscribe();

        App.processProblemArchiveSubscription.consumer.disconnect();

        App.processProblemArchiveSubscription = undefined;
    }
});
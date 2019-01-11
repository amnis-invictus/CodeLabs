(function () {
  function processProblemArchiveLog() {
    var block = $(this);

    function received(data) {
      block.append('<p>' + data + '</p>');

      if (data === 'Done.')
        $('form#new_problem :submit').prop('disabled', false);
    }

    App.processProblemArchiveSubscription = App.cable.subscriptions.create(
      { channel: 'ProcessProblemArchiveChannel', id: block.data('channel-id') },
      { received: received }
    );
  }

  jQuery.fn.extend({ processProblemArchiveLog: function () { return this.each(processProblemArchiveLog); } });

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
})();

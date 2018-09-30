function initializeTestFieldsSwap() {
  $(document).on('click', '[data-toggle=test-fields-swap]', function () {
    var row = $(this).closest('tr');

    var items = [
      row.find('.problem_tests_input'), row.find('.problem_tests_input_text'),
      row.find('.problem_tests_answer'), row.find('.problem_tests_answer_text')
    ];

    items.forEach(function (item) { item.toggleClass('hidden'); });
  });
};

document.addEventListener('turbolinks:load', function () {
  initializeTestFieldsSwap();
});

(function () {
  function onSortSuccess(result) { $('table tbody').html(result); }

  function sortTable(data) {
    $.ajax({ url: '', data: JSON.stringify(data), success: onSortSuccess });
  }

  function getRemote(remote_url) {
    return JSON.parse($.ajax({ type: "GET", url: remote_url, async: false }).responseText);
  }

  function initializeSortBy() {
    var usernames = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.whitespace,
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      local: getRemote('/v2/tests/users.json')
    });

    $('#sortByUser').typeahead(null, { name: 'usernames', source: usernames });

    var problems = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.whitespace,
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      local: getRemote('/v2/tests/problems.json')
    });

    $('#sortByTask').typeahead(null, { name: 'problems', source: problems });

    var groups = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.whitespace,
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      local: getRemote('/v2/tests/groups.json')
    });

    $('#sortByGroup').typeahead(null, { name: 'groups', source: groups });

    // --------------- Process the selection -------------- //

    var data = { status: null, user: null, problem: null, group: null };

    $('#sortByStatus').change(function () {
      data.status = $(this).find("option:selected").val();

      sortTable(data);
    });

    $('#sortByTask').bind('typeahead:select', function (e) {
      data.problem = e.target.value;

      sortTable(data);
    });

    $('#sortByUser').bind('typeahead:select', function (e) {
      data.user = e.target.value;

      sortTable(data);
    });

    $('#sortByGroup').bind('typeahead:select', function (e) {
      data.group = e.target.value;

      sortTable(data);
    });
  }

  $(document).on('turbolinks:load', function () {
    if (typeof sortByUser !== 'undefined')
      initializeSortBy();
  });
})();

'use strict';

(function () {
  function suggestion(data) { return data.search_suggestion; }

  function onSelect(block) {
    var input = block.closest('form').find('input[name="' + block.attr('name') + '"]:hidden');

    return function (_, selected) { input.val(selected.id); };
  }

  var bloodhoundOptions = {
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: { wildcard: '%Q%', url: '/users?username=%Q%' }
  };

  var typeaheadOptions = { highlight: true, minLength: 3 }

  var typeaheadDatasets = {
    display: 'name',
    source: new Bloodhound(bloodhoundOptions),
    templates: { suggestion: suggestion }
  }

  function initializeUserSearch() {
    var block = $(this);

    block.typeahead(typeaheadOptions, typeaheadDatasets);

    block.bind('typeahead:select', onSelect(block));
  }

  $.fn.extend({ userSearch: function () { return this.each(initializeUserSearch); } });
})();

document.addEventListener('turbolinks:load', function () { $('input[data-role=user-search]').userSearch(); });

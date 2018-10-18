'use strict';

jQuery.fn.extend({
  tagsSelect: function () {
    return this.each(function () {
      var block = $(this);

      var data = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('text'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        prefetch: { url: "/tags.json", cache: false }
      });

      data.initialize();

      block.tagsinput({
        itemValue: 'value',
        itemText: 'text',
        typeaheadjs: {
          name: 'cities',
          displayKey: 'text',
          source: data.ttAdapter()
        }
      });

      $.map(this.options, function (option) {
        block.tagsinput('add', { value: option.value, text: option.text });
      });
    });
  }
});

document.addEventListener('turbolinks:load', function () {
  $('[data-role=tags-select]').tagsSelect();
});

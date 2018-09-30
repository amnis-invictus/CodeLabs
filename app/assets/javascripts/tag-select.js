jQuery.fn.extend({
  tagSelect: function () {
    return this.each(function () {
      var block = $(this);

      var data = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('text'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        prefetch: block.data('path')
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
    })
  }
});

document.addEventListener('turbolinks:load', function () {
  $('[data-role=search-select]').tagSelect()
});

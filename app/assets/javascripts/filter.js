(function () {
  const buildBloodhound = ({ url }) => new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: { wildcard: '%', url }
  });

  const suggestionTemplate = (d) => `<a class="dropdown-item" href="#" data-id="${d.id}">${d.search_suggestion}</a>`;

  function initFilter() {
    const bloodhound = buildBloodhound(this.dataset);
    bloodhound.initialize();

    const maxSuggestions = this.dataset.maxSuggestions || 5;
    const delay = this.dataset.delay || 500;

    const $this = $(this);
    const $container = $this.find('[data-target=suggestions]');
    const $idInput = $this.find('input[data-target=id]');
    const $queryInput = $this.find('input[data-target=query]');
    const $clearButton = $this.find('[data-target=clear]');
    const $form = $(this).closest('form');

    const updateSuggestions = (data) => $container.html(data.slice(0, maxSuggestions).map(suggestionTemplate).join(''));
    const runSearch = debounce((value) => bloodhound.search(value, updateSuggestions, updateSuggestions), delay);

    $queryInput.on('input', function () { runSearch(this.value); });

    $container.on('click', '.dropdown-item[data-id]', function () {
      $idInput.val(this.dataset.id);
      $form.trigger('submit');
    });

    $clearButton.on('click', function () {
      $idInput.val('');
      $form.trigger('submit');
    });

    $this.on('shown.bs.dropdown', function () { setTimeout(() => $queryInput.trigger('focus')); });

    $this.on('click', function (e) { e.stopPropagation(); });
  }

  $.fn.extend({ initFilter: function () { return this.each(initFilter); } });
})();

document.addEventListener('turbolinks:load', function () { $('[data-role=filter]').initFilter(); });

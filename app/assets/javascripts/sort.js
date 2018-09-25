if (typeof sortByUser !== 'undefined') {
    window.addEventListener('turbolinks:load', () => {
        var usernames = new Bloodhound({
            datumTokenizer: Bloodhound.tokenizers.whitespace,
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            prefetch: '/v2/tests/users.json'
        });

        $('#sortByUser').typeahead(null, {
                name: 'usernames',
            source: usernames
        });


        var problems = new Bloodhound({
            datumTokenizer: Bloodhound.tokenizers.whitespace,
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            prefetch: '/v2/tests/problems.json'
        });

        $('#sortByTask').typeahead(null, {
                name: 'problems',
            source: problems
        });


        var statuses = new Bloodhound({
            datumTokenizer: Bloodhound.tokenizers.whitespace,
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            prefetch: '/v2/tests/statuses.json'
        });

        $('#sortByStatus').typeahead(null, {
                name: 'statuses',
            source: statuses
        });
    });
}
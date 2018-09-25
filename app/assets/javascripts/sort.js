function getRemote(remote_url) {
    return $.ajax({
        type: "GET",
        url: remote_url,
        async: false
    }).responseText;
}

if (typeof sortByUser !== 'undefined') {
    window.addEventListener('turbolinks:load', () => {
        let local = {
            users: null,
            problems: null,
            statuses: null
        };

        local.users = JSON.parse(getRemote('/v2/tests/users.json'));
        local.problems = JSON.parse(getRemote('/v2/tests/problems.json'));
        local.statuses = JSON.parse(getRemote('/v2/tests/statuses.json'));

        const usernames = new Bloodhound({
            datumTokenizer: Bloodhound.tokenizers.whitespace,
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            local: local.users
        });

        $('#sortByUser').typeahead(null, {
            name: 'usernames',
            source: usernames
        });


        const problems = new Bloodhound({
            datumTokenizer: Bloodhound.tokenizers.whitespace,
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            local: local.problems
        });

        $('#sortByTask').typeahead(null, {
            name: 'problems',
            source: problems
        });


        const statuses = new Bloodhound({
            datumTokenizer: Bloodhound.tokenizers.whitespace,
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            local: local.statuses
        });

        $('#sortByStatus').typeahead(null, {
            name: 'statuses',
            source: statuses
        });
    });
}
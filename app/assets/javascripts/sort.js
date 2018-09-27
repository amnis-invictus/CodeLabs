function getRemote(remote_url) {
    return $.ajax({
        type: "GET",
        url: remote_url,
        async: false
    }).responseText;
}

$(document).on('turbolinks:load', () => {
    if (typeof sortByUser !== 'undefined')
        (() => {
            let local = {
                users: null,
                problems: null,
                statuses: null,
                groups: null
            };

            local.users = JSON.parse(getRemote('/v2/tests/users.json'));
            local.groups = JSON.parse(getRemote('/v2/tests/groups.json'));
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

            const groups = new Bloodhound({
                datumTokenizer: Bloodhound.tokenizers.whitespace,
                queryTokenizer: Bloodhound.tokenizers.whitespace,
                local: local.groups
            });

            $('#sortByGroup').typeahead(null, {
                name: 'groups',
                source: groups
            });
        })();
})
;
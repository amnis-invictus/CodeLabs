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
                groups: null
            };

            local.users = JSON.parse(getRemote('/v2/tests/users.json'));
            local.groups = JSON.parse(getRemote('/v2/tests/groups.json'));
            local.problems = JSON.parse(getRemote('/v2/tests/problems.json'));

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

            const groups = new Bloodhound({
                datumTokenizer: Bloodhound.tokenizers.whitespace,
                queryTokenizer: Bloodhound.tokenizers.whitespace,
                local: local.groups
            });

            $('#sortByGroup').typeahead(null, {
                name: 'groups',
                source: groups
            });

            // --------------- Process the selection -------------- //

            let data = {status: null, user: null, problem: null, group: null};

            $('#sortByStatus').change(function () {
                data.status = $(this).find("option:selected").val();

                sortTheTable(data);
            });

            $('#sortByTask').bind('typeahead:select', function (e) {
                data.problem = e.target.value;

                sortTheTable(data);
            });

            $('#sortByUser').bind('typeahead:select', function (e) {
                data.user = e.target.value;

                sortTheTable(data);
            });

            $('#sortByGroup').bind('typeahead:select', function (e) {
                data.group = e.target.value;

                sortTheTable(data);
            });

            function sortTheTable(data) {
                $.ajax({
                    url: '',
                    data: JSON.stringify(data),
                    success: (result) => {
                        $('table tbody').html(result);
                    }
                });
            }

            // ---------------------------------------------------- //
        })();
});
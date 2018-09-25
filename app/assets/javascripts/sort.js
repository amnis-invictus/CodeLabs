if (typeof sortByUser !== 'undefined') {
    window.addEventListener('turbolinks:load', () => {
        var usernames = new Bloodhound({
            datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            prefetch: {
                url: '/v2/tests/users.json',
                filter: function (list) {
                    return list.map(cityname => {
                        return {name: cityname}
                    });
                }
            },
        });
        usernames.initialize();

        $('#sortByUser').tagsinput({
            typeaheadjs: {
                name: 'usernames',
                displayKey: 'name',
                valueKey: 'name',
                source: usernames.ttAdapter()
            }
        });


        var problems = new Bloodhound({
            datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            prefetch: {
                url: '/v2/tests/problems.json',
                filter: function (list) {
                    return list.map(cityname => {
                        return {name: cityname}
                    });
                }
            }
        });
        problems.initialize();

        $('#sortByTask').tagsinput({
            typeaheadjs: {
                name: 'problems',
                displayKey: 'name',
                valueKey: 'name',
                source: problems.ttAdapter()
            }
        });


        var statuses = new Bloodhound({
            datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            prefetch: {
                url: '/v2/tests/statuses.json',
                filter: function (list) {
                    return list.map(cityname => {
                        return {name: cityname}
                    });
                }
            },
        });
        statuses.initialize();

        $('#sortByStatus').tagsinput({
            typeaheadjs: {
                name: 'statuses',
                displayKey: 'name',
                valueKey: 'name',
                source: statuses.ttAdapter()
            }
        });
    });
}
$(function () {
    if (confirm_users_page)
        (() => {
            $('.confirm-user').click(function () {
                const $btn = $(this).button('loading');

                //$.ajax(/*TODO*/);

                $btn.button('reset');
            });

            $('.rm-user').click(function () {
                const $btn = $(this).button('loading');

                //$.ajax(/*TODO*/);

                $btn.button('reset');
            });
        })();
});
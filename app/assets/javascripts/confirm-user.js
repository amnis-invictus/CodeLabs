$(function () {
    if (typeof confirm_users_page !== 'undefined')
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
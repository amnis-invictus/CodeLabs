'use strict';

$(function () {
    if (typeof confirm_users_page !== 'undefined') (function () {
        $('.confirm-user').click(function () {
            var $btn = $(this).button('loading');

            //$.ajax(/*TODO*/);

            $btn.button('reset');
        });

        $('.rm-user').click(function () {
            var $btn = $(this).button('loading');

            //$.ajax(/*TODO*/);

            $btn.button('reset');
        });
    })();
});
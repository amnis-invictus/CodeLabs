if (typeof add_problem_form !== "undefined")
    window.addEventListener('load', () => {
        add_problem_form.onsubmit = function (e) {
            e.preventDefault();


            // -------------- Validation --------------- //

            if (isNaN(parseInt(memory.value)))
                return alert('В поле "Память" введено не число');

            if (isNaN(parseInt(time.value)))
                return alert('В поле "Время" введено не число');

            if (isNaN(parseInt(rtime.value)))
                return alert('В поле "Настоящее время" введено не число');

            if (caption.value.length === 0)
                return alert('Поле "Заголовок" должно быть заполнено');

            if (text.innerText.length === 0)
                return alert('Поле "Текст" должно быть заполнено');

            if (techtext.innerText.length === 0)
                return alert('Поле "Технический текст" должно быть заполнено');

            if (caption.value.length === 0)
                return alert('Поле "Автор" должно быть заполнено');

            if (tags.innerText.length === 0)
                return alert('Поле "Теги" должно быть заполнено');

            if (checker.files.length === 0)
                return alert('Загрузите файл-чекер');

            // ----------------------------------------- //


            // ----------- Prepare data --------------- //

            let allTranslations = {},
                input = $('<input/>'),
                obj = translations.children;

            obj.forEach(item => {
                console.log(item);
            });

            allTranslations = JSON.stringify(allTranslations);

            input.attr('type', 'hidden');
            input.attr('value', allTranslations);
            input.attr('name', 'translations');

            $(add_problem_form).append(input);

            // ---------------------------------------- //


            //Success, submit
            add_problem_form.submit();
        };
    });

$(function () {
    $("#examples").find(".btn").on('click', function () {
        const el = $("#examples .btn"),
            $input_field = $("<input>").attr("type", "text").attr("class", "form-control"),
            $input_col = $("<div>").attr("class", "col-lg-6 col-md-6 col-sm-6").css('margin-top', '5px'),
            $answer_field = $("<input>").attr("type", "text").attr("class", "form-control"),
            $answer_col = $("<div>").attr("class", "col-lg-6 col-md-6 col-sm-6").css('margin-top', '5px'),
            $row = $("<div></div>").attr("class", "row");

        $input_col.append($input_field);
        $answer_col.append($answer_field);
        $row.append($input_col);
        $row.append($answer_col);

        el.before($row);
    });

    $("#tests_part").find(".btn").on('click', function () {
        const $table = $("#tests tbody"),
            $num_field = $("<input>").attr("type", "text").attr("class", "form-control"),
            $btn = $('<button>').attr('class', 'btn btn-warning btn-switch').attr('type', 'button').css('margin-top', '5px').text('Сменить тип теста').on('click', function () {
                $(this).parent().siblings().each(function () {
                    $(this).find('textarea').length === 0
                        ?
                        $(this).html("<textarea rows='2' class='form-control'></textarea>")
                        :
                        $(this).html("<input style='margin-right: -8px;' type='file' />")
                });
            });

        $num_cell = $("<td>");

        $num_cell.append($num_field);
        $num_cell.append($btn);

        const $input_field = $("<textarea>").attr("rows", "2").attr("class", "form-control"),
            $input_cell = $("<td>");

        $input_cell.append($input_field);

        const $answer_field = $("<textarea>").attr("rows", "2").attr("class", "form-control"),
            $answer_cell = $("<td>");

        $answer_cell.append($answer_field);

        const $row = $("<tr>");

        $row.append($num_cell);
        $row.append($input_cell);
        $row.append($answer_cell);

        $table.append($row);
    });

    $(translation_block).find('button').on('click', () => {
        const newTranslation = $("<div class='translation'><div class=\"form-group\">\n" +
            "                            <label for=\"lang\">Выберите язык</label>\n" +
            "                            <select class=\"form-control\" id=\"lang\">\n" +
            "                                <option value=\"uk\">Украинский</option>\n" +
            "                                <option value=\"ru\">Русский</option>\n" +
            "                                <option value=\"en\">Английский</option>\n" +
            "                            </select>\n" +
            "                        </div>\n" +
            "\n" +
            "                        <label for=\"caption\">Заголовок</label>\n" +
            "                        <div class=\"form-group\">\n" +
            "                            <input id=\"caption\" type=\"text\" class=\"form-control\">\n" +
            "                        </div>\n" +
            "\n" +
            "                        <label for=\"text\">Текст</label>\n" +
            "                        <div class=\"form-group\">\n" +
            "                            <textarea id=\"text\" rows=\"2\" class=\"form-control\"></textarea>\n" +
            "                        </div>\n" +
            "\n" +
            "                        <label for=\"techtext\">Технический текст</label>\n" +
            "                        <div class=\"form-group\">\n" +
            "                            <textarea id=\"techtext\" rows=\"2\" class=\"form-control\"></textarea>\n" +
            "                        </div>\n" +
            "\n" +
            "                        <label for=\"author\">Автор</label>\n" +
            "                        <div class=\"form-group\">\n" +
            "                            <input id=\"author\" type=\"text\" class=\"form-control\">\n" +
            "                        </div>\n" +
            "\n" +
            "                        <label for=\"tags\">Теги</label>\n" +
            "                        <div class=\"form-group\">\n" +
            "                            <textarea id=\"tags\" rows=\"3\" class=\"form-control\"></textarea>\n" +
            "                            <p class=\"help-block\">Каждый тег с новой строки.</p>\n" +
            "                        </div></div>");

        $('#translations').append(newTranslation);
    });
});
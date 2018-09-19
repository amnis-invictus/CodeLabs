//
// ReferenceError: form is not defined
//

// form.onsubmit = function (e) {
//     e.preventDefault();

//     if (isNaN(parseInt(memory.value)))
//         return alert('В поле "Память" введено не число');

//     if (isNaN(parseInt(time.value)))
//         return alert('В поле "Время" введено не число');

//     if (isNaN(parseInt(rtime.value)))
//         return alert('В поле "Настоящее время" введено не число');

//     form.submit();
// };

$(document).ready(function () {
	$("#examples").find(".btn").on('click', function (e) {
		var el = $("#examples .btn");
		
		$input_field = $("<input>").attr("type", "text").attr("class", "form-control");
		$input_col = $("<div>").attr("class", "col-lg-6 col-md-6 col-sm-6");

		$answer_field = $("<input>").attr("type", "text").attr("class", "form-control");
		$answer_col = $("<div>").attr("class", "col-lg-6 col-md-6 col-sm-6");

		$row = $("<div></div>").attr("class", "row");

		$input_col.append($input_field);
		$answer_col.append($answer_field);
		$row.append($input_col);
		$row.append($answer_col);
		
		el.before($row);
	});
});





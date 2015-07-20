$(document).ready(function() {
	$('#check-in-formff').submit(function(e) {
		e.preventDefault();
		var ticket_num = $("#input-ticket-number").val();
		var last_name = $("#input-last-name").val();

		$.ajax({
			type : "POST",
			dataType : "json",
			url : "check_in",
			data : {
				'ticket_num' : ticket_num,
				'last_name' : last_name
			},
			cache : false,
			success : function(responseObj) {

				var arr = new Array();
				var parseObj = JSON.stringify(responseObj);
				arr = JSON.parse(parseObj);

				if (arr.success) {
					$("#print-boarding-pass").html(arr.response);

				}
			}
		});

	});
});
$(document).ready(function() {
	$('#clearance-form').submit(function(e) {
		e.preventDefault();
		var airport = $("#airport").val();
		var clearance_time = $("#input-clearance").val();
		var airplane_type = $("#airplane-type").val();

		$.ajax({
			type : "POST",
			dataType : "json",
			url : "clearance",
			data : {
				'airport' : airport,
				'airplane_type' : airplane_type,
				'clearance_time' : clearance_time
			},
			cache : false,
			success : function(responseObj) {

				var arr = new Array();
				var parseObj = JSON.stringify(responseObj);
				arr = JSON.parse(parseObj);

				if (arr.success) {
					$("#clear-runways").html(arr.response);

				}
			}
		});

	});
});
$(document).ready(function() {
	$('#clearance-form').submit(function(e) {
		e.preventDefault();
		var airport = $("#airport").val();
		var input_clearance = $("#input-clearance").val();
		var flight_segment = $("#flight-segment").val();
		var controller = $("#controller").val();

		$.ajax({
			type : "POST",
			dataType : "json",
			url : "clearance",
			data : {
				'airport' : airport,
				'input_clearance' : input_clearance,
				'flight_segment' : flight_segment,
				'controller': controller
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
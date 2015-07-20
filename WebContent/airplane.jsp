<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<t:genericpage>
	<jsp:attribute name="body">	
		<div class="container">
		<div class="well">

		<div id="responsediv" style="display: none">
			<!-- the response in these label are coming from server -->
			<div class="alert alert-success" role="alert">
				Insertion was successful.
			</div> 
		</div>	
      	<form id="insertairplane">

        <h3>Enter new airplane</h3>

		<div class="form-group">
				     <label class="control-label">Airplane ID</label>
					<input type="number" class="form-control" id="airplaneid"
							name="airplaneid" placeholder="airplaneid">
		</div>
				
		<div class="form-group">
				     <label class="control-label">Size Class</label>
					<input type="text" class="form-control" id="size_class"
							name="size_class" placeholder="size_class">
		</div>
		
		<div class="form-group">
				     <label class="control-label">Airplane Type</label>
					<input type="text" class="form-control" id="airplane_type"
							name="airplane_type" placeholder="airplane_type">
		</div>

        <div class="form-group">
				     <label class="control-label">Airplane Range</label>
					<input type="number" class="form-control" id="airplane_range"
							name="airplane_range" placeholder="airplane_range">
		</div>
      
		<div class="form-group">
				     <label class="control-label">Total Seats</label>
					<input type="number" class="form-control" id="total_seats"
							name="total_seats" placeholder="total_seats">
		</div>
        
	 <div class="form-group">
				     <label class="control-label">Airline ID</label>
					<input type="number" class="form-control" id="airline_id"
							name="airline_id" placeholder="airline_id">
		</div>
	 <input type="button" value="Submit" id="formSubmit" class="btn btn-default">
		
        
      </form>
      </div>
      </div>

	<script>
		// data array

		$(document).ready(function() {

			$('#insertairplane').validate({ // initialize the plugin
				rules : {
					airplaneid : {
						required : true,
						integer : true
					},
					size_class : {
						required : true,
						lettersonly : true
					},
					airplane_type : {
						required : true,
						alphanumeric : true,

					},
					airplane_range : {
						required : true,
						integer : true
					},
					total_seats : {
						required : true,
						integer : true
					},
					airline_id : {
						required : true,
						integer : true
					}
				}
			});

		});

		$("#formSubmit")
				.click(
						function() {
							if ($('#insertairplane').valid()) {
								var airplaneid = $("#airplaneid").val();
								var size_class = $("#size_class").val();
								var airplane_type = $("#airplane_type").val();
								var airplane_range = $("#airplane_range").val();
								var total_seats = $("#total_seats").val();
								var airline_id = $("#airline_id").val();
								var airplane = new Object();
								airplane.airplaneid = airplaneid;
								airplane.size_class = size_class;
								airplane.airplane_type = airplane_type;
								airplane.airplane_range = airplane_range;
								airplane.total_seats = total_seats;
								airplane.airline_id = airline_id;

								var mydata = JSON.stringify(airplane);

								$
										.ajax({
											type : "POST",
											url : "airplane",
											dataType : "json",
											data : mydata,
											contentType : 'application/json',
											mimeType : 'application/json',
											success : function(data) {

												document
														.getElementById('responsediv').style.display = 'block';
												document.getElementById(
														"insertairplane")
														.reset();
												//alert("Insertion successful");
											},
											error : function(data, status,
													error) {

												alert("Insertion not successful");
											}
										});
								return false;

							}
						});
	</script>    	
	</jsp:attribute>
</t:genericpage>
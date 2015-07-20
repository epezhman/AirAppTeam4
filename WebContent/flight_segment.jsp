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
                <form id="insertflightsegment" >

                    <h3>Add new flight segment</h3>
                    
                    <div class="form-group">
					     <label class="control-label">Flight Segment ID</label>			        
						<input type="number" class="form-control" id="flight_segment_id"
							name="flight_segment_id" placeholder="flight_segment_id">
					</div>
					
					<div class="form-group">
					     <label class="control-label">Duration</label>			        
						  <input type="number" class="form-control" id="duration_minutes"
							name="duration_minutes" placeholder="duration_minutes">
					</div>
					
					<div class="form-group">
					     <label class="control-label">Number of miles</label>			        
						 <input type="number" class="form-control" id="number_of_miles"
							name="number_of_miles" placeholder="number_of_miles">
					</div>

					<div class="form-group">
					     <label class="control-label">Departure Date & Time</label>			        
							<input type="text" value="" id="datetimepicker"
							class="form-control" />
					</div>
					
					<div class="form-group">
					     <label class="control-label">Arrival Date & Time</label>			        
							<input type="text" value="" class="form-control"
							id="datetimepicker1" />
					</div>

                    <div class="form-group">
					     <label class="control-label">Airline ID</label>			        
								<input type="number" class="form-control" id="airline_id"
							name="airline_id" placeholder="airline_id">
					</div>
                    
                     <div class="form-group">
                     	<label class="control-label">Airport Destination ID</label>			      
							 <input type="text" class="form-control"
							id="airport_destination_id" name="airport_destination_id"
							placeholder="airport_destination_id">
					</div>
                   
					 <div class="form-group">
					  		<label class="control-label">Airport Departure ID</label>			      
							 <input type="text" class="form-control"
							id="airport_departure_id" name="airport_departure_id"
							placeholder="airport_departure_id">
					</div>                 
                    
					 <div class="form-group">
					  <label class="control-label">Airplane ID</label>			      
							 <input type="text" class="form-control" id="airplane_Id"
							name="airplane_Id" placeholder="airplane_Id">
					</div>


					<div class="form-group">
					  <label class="control-label">Flight Number</label>			      
							 <input type="text" class="form-control" id="flight_number"
							name="flight_number" placeholder="flight_number">
					</div>
					
					<div class="form-group">
					  <label class="control-label">Price</label>			      
							 <input type="number" class="form-control" id="price" name="price"
							placeholder="price">
					</div>

                    <input type="button" value="Submit" id="formSubmit"
						class="btn btn-default">
					              
                </form>
            </div>
        </div>

      </jsp:attribute>
</t:genericpage>


<script>
	$('#datetimepicker').datetimepicker();

	$('#datetimepicker1').datetimepicker();

	$(document).ready(function() {
		$('#insertflightsegment').validate({ // initialize the plugin
			rules : {
				flight_segment_id : {
					required : true,
					integer : true
				},
				duration_minutes : {
					required : true,
					integer : true
				},
				number_of_miles : {
					required : true,
					integer : true
				},
				departure_time : {
					required : true,
					time : true
				},
				arrival_time : {
					required : true,
					time : true
				},
				airline_id : {
					required : true,
					integer : true
				},
				airplane_Id : {
					required : true,
					integer : true
				},
				airport_departure_id : {
					required : true,
					lettersonly : true
				},
				airport_destination_id : {
					required : true,
					lettersonly : true
				},
				flight_number : {
					required : true
				},
				price : {
					required : true,
					integer : true
				},

			}

		});

	});

	$("#formSubmit")
			.click(
					function() {
						if ($('#insertflightsegment').valid()) {
							var flight_segment_id = $("#flight_segment_id")
									.val();
							var duration_minutes = $("#duration_minutes").val();
							var number_of_miles = $("#number_of_miles").val();
							var departure_time = $('#datetimepicker').val();
							var arrival_time = $("#datetimepicker1").val();
							var airline_id = $("#airline_id").val();
							var airport_departure_id = $(
									"#airport_departure_id").val();
							var airport_destination_id = $(
									"#airport_destination_id").val();
							var flight_number = $("#flight_number").val();
							var price = $("#price").val();

							var flight_segment = new Object();
							flight_segment.flight_segment_id = flight_segment_id;
							flight_segment.duration_minutes = duration_minutes;
							flight_segment.number_of_miles = number_of_miles;
							flight_segment.departure_time = departure_time;
							flight_segment.arrival_time = arrival_time;
							flight_segment.airline_id = airline_id;
							flight_segment.airport_departure_id = airport_departure_id;
							flight_segment.airport_destination_id = airport_destination_id;
							flight_segment.flight_number = flight_number;
							flight_segment.price = price;
							flight_segment.airplane_id = $("#airplane_Id")
									.val();

							var mydata = JSON.stringify(flight_segment);

							if (airport_departure_id == airport_destination_id) {
								alert("Departure and Desitnation cannot be same");
							} else {

								$
										.ajax({
											type : "POST",
											dataType : "json",
											url : "flight_segment",
											dataType : "json",

											data : mydata,
											contentType : 'application/json',
											mimeType : 'application/json',
											success : function(data) {

												document
														.getElementById('responsediv').style.display = 'block';
												document.getElementById(
														"insertflightsegment")
														.reset();
											},
											error : function(data, status,
													error) {
												alert("Insertion not successful");
											}
										});
								return false;
							}
						}

					});
</script>




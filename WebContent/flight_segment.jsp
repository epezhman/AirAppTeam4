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
                <form id="insertflightsegment" class="form-horizontal">

                    <legend>Add new flight segment</legend>

                    <div class="control-group">
                        <label class="control-label">Flight Segment ID</label>
                        <div class="controls">
                            <div class="input-prepend">
                                <span class="add-on"><i
									class="icon-user"></i></span>
                                <input type="number"
									class="input-xlarge" id="flight_segment_id"
									name="flight_segment_id" placeholder="flight_segment_id">
                            </div>
                        </div>
                    </div>
                    <div class="control-group ">
                        <label class="control-label">Duration</label>
                        <div class="controls">
                            <div class="input-prepend">
                                <span class="add-on"><i
									class="icon-user"></i></span>
                                <input type="number"
									class="input-xlarge" id="duration_minutes"
									name="duration_minutes" placeholder="duration_minutes">
                            </div>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">Number of miles</label>
                        <div class="controls">
                            <div class="input-prepend">
                                <span class="add-on"><i
									class="icon-envelope"></i></span>
                                <input type="number"
									class="input-xlarge" id="number_of_miles"
									name="number_of_miles" placeholder="number_of_miles">
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">Departure Date & Time</label>
                        <div class="controls">
                         <input type="text" value="" id="datetimepicker" />
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">Arrival Date & Time</label>
                        <div class="controls">
                            <input type="text" value=""
								id="datetimepicker1" />
                           
                        </div>
                    </div>


                    <div class="control-group">
                        <label class="control-label">Airline ID</label>
                        <div class="controls">
                            <div class="input-prepend">
                                <span class="add-on"><i
									class="icon-envelope"></i></span>
                                <input type="number"
									class="input-xlarge" id="airline_id" name="airline_id"
									placeholder="airline_id">
                            </div>
                        </div>
                    </div>


                    <div class="control-group">
                        <label class="control-label">Airport Destination ID</label>
                        <div class="controls">
                            <div class="input-prepend">
                                <span class="add-on"><i
									class="icon-envelope"></i></span>
                                <input type="text" class="input-xlarge"
									id="airport_destination_id" name="airport_destination_id"
									placeholder="airport_destination_id">
                            </div>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">Airport Departure ID</label>
                        <div class="controls">
                            <div class="input-prepend">
                                <span class="add-on"><i
									class="icon-envelope"></i></span>
                                <input type="text" class="input-xlarge"
									id="airport_departure_id" name="airport_departure_id"
									placeholder="airport_departure_id">
                            </div>
                        </div>
                    </div>

					   <div class="control-group">
                        <label class="control-label">Airplane Type</label>
                        <div class="controls">
                            <div class="input-prepend">
                                <span class="add-on"><i
									class="icon-envelope"></i></span>
                                <input type="text" class="input-xlarge"
									id="airplane_type" name="airplane_type"
									placeholder="airplane_type">
                            </div>
                        </div>
                    </div>
					
                    <div class="control-group">
                        <label class="control-label"></label>
                        <div class="controls">
                            <input type="button" value="Submit"
								id="formSubmit">

                        </div>
                    </div>

                </form>
            </div>
        </div>

      </jsp:attribute>
</t:genericpage>

<script src="./resources/js/jquery.validate.js"></script> 
<script src="./resources/js/additional-methods.js"></script>

<script>
  

	$('#datetimepicker').datetimepicker();
	
	$('#datetimepicker1').datetimepicker();
	
	$(document).ready(function(){
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
                airport_departure_id : {
                    required : true,
                    lettersonly : true
                },
                airport_destination_id : {
                    required : true,
                    lettersonly : true
                }
                
            }
        
        });

    });

    $("#formSubmit").click(function() {
    	if($('#insertflightsegment').valid()){
                var flight_segment_id = $("#flight_segment_id").val();
                var duration_minutes = $("#duration_minutes").val();
                var number_of_miles = $("#number_of_miles").val();
                var departure_time = $('#datetimepicker').val();
                var arrival_time = $("#datetimepicker1").val();
                var airline_id = $("#airline_id").val();
                var airport_departure_id = $("#airport_departure_id").val();
                var airport_destination_id = $("#airport_destination_id").val();
                              		
                var flight_segment = new Object();
                flight_segment.flight_segment_id = flight_segment_id;
                flight_segment.duration_minutes = duration_minutes;
                flight_segment.number_of_miles = number_of_miles;
                flight_segment.departure_time = departure_time;
                flight_segment.arrival_time = arrival_time;
                flight_segment.airline_id = airline_id;
                flight_segment.airport_departure_id = airport_departure_id;
                flight_segment.airport_destination_id = airport_destination_id;
  				if($("#airplane_type").val() != null){
                	flight_segment.airplane_type = $("#airplane_type").val();	
                }

                var mydata = JSON.stringify(flight_segment);
                
                if( airport_departure_id == airport_destination_id){
                	alert("Departure and Desitnation cannot be same");
                }
                else {
            
                    $.ajax({
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
                                    //alert("Insertion successful");
                                },
                                error : function(data, status, error) {
                                    //console.log(data);
                                    //console.log(status);
                                    //console.log(error);
                                    alert("Insertion not successful");
                                }
                            });
                    return false;
                }
                }
    
            });
</script>




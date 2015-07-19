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
		      	<form id="insertairport">
		
		        <h3>Enter new airport</h3>
		
				<div class="form-group">
				     <label class="control-label">Airport ID</label>
		            <input type="text" class="form-control" id="airportid"
									name="airportid" placeholder="airportid">
				</div>
				
				<div class="form-group">
				     <label class="control-label">Name</label>
		            <input type="text" class="form-control" id="name"
									name="name" placeholder="name">
				</div>
				
				<div class="form-group">
				     <label class="control-label">City</label>
		            <input type="text" class="form-control" id="city"
									name="city" placeholder="city">
				</div>
				
				<div class="form-group">
				     <label class="control-label">Country</label>
		            <input type="text" class="form-control" id="country"
									name="country" placeholder="country">
				</div>
		              <input type="button" value="Submit" id="formSubmit" class="btn btn-default">		       
		      </form>
	      </div>
      </div>
    <script src="./resources/js/jquery.validate.js"></script> 
    <script src="./resources/js/additional-methods.js"></script>
    
	<script>
		// data array

		$(document).ready(function() {

			$('#insertairport').validate({ // initialize the plugin
				rules : {
					airportid : {
						required : true,
						lettersonly : true,
						nowhitespace : true
					},
					name : {
						required : true,
						lettersonly : true
					},
					city : {
						required : true,
						lettersonly : true
					},
					country : {
						required : true,
						lettersonly : true
					}
				}
			});

		});

		$("#formSubmit")
				.click(
						function() {
							if ($('#insertairport').valid()) {
								var airportid = $("#airportid").val();
								var name = $("#name").val();
								var city = $("#city").val();
								var country = $("#country").val();

								var airport = new Object();
								airport.airportid = airportid;
								airport.name = name;
								airport.city = city;
								airport.country = country;

								var mydata = JSON.stringify(airport);

								$
										.ajax({
											type : "POST",
											dataType : "json",
											url : "airport",
											dataType : "json",

											data : mydata,
											contentType : 'application/json',
											mimeType : 'application/json',
											success : function(data) {

												document
														.getElementById('responsediv').style.display = 'block';
												document.getElementById(
														"insertairport")
														.reset();
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
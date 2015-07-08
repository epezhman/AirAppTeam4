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
      	<form id="insertairline" class="form-horizontal">

        <legend>Enter new airline</legend>

        <div class="control-group">
            <label class="control-label">Airline ID</label>
            <div class="controls">
                <div class="input-prepend">
                <span class="add-on"><i class="icon-user"></i></span>
                    <input type="number" class="input-xlarge"
									id="airline_id" name="airline_id" placeholder="airline_id">
                </div>
            </div>
        </div>
        <div class="control-group ">
            <label class="control-label">Airline Name</label>
            <div class="controls">
                <div class="input-prepend">
                <span class="add-on"><i class="icon-user"></i></span>
                    <input type="text" class="input-xlarge"
									id="airline_name" name="airline_name" placeholder="airline_name">
                </div>
            </div>
        </div>

        <div class="control-group">
        <label class="control-label">Headquarters</label>
	    <div class="controls">
		<div class="input-prepend">
        <span class="add-on"><i class="icon-envelope"></i></span>
		<input type="text" class="input-xlarge" id="headquarters"
									name="headquarters" placeholder="headquarters">
        </div>
		 </div>
	</div>
	  <div class="control-group">
        <label class="control-label">Headquarters City</label>
	    <div class="controls">
		<div class="input-prepend">
        <span class="add-on"><i class="icon-envelope"></i></span>
		<input type="text" class="input-xlarge" id="hq_city"
									name="hq_city" placeholder="hq_city">
        </div>
		 </div>
	</div>
	
	  <div class="control-group">
        <label class="control-label">Headquarters Country</label>
	    <div class="controls">
		<div class="input-prepend">
        <span class="add-on"><i class="icon-envelope"></i></span>
		<input type="text" class="input-xlarge" id="hq_country"
									name="hq_country" placeholder="hq_country">
        </div>
		 </div>
	</div>
	
	  <div class="control-group">
        <label class="control-label">Airport Hub</label>
	    <div class="controls">
		<div class="input-prepend">
        <span class="add-on"><i class="icon-envelope"></i></span>
		<input type="text" class="input-xlarge" id="airport_hub"
									name="airport_hub" placeholder="airport_hub">
        </div>
		 </div>
	</div>
      
        <div class="control-group">
        <label class="control-label"></label>
          <div class="controls">
         <input type="button" value="Submit" id="formSubmit">
           
          </div>
    </div>
      </form>
      </div>
      </div>
      </jsp:attribute>
</t:genericpage>
    <script src="./resources/js/jquery.validate.js"></script> 
    <script src="./resources/js/additional-methods.js">	</script>
	<script>
	$(document).ready(function () {

    $('#insertairline').validate({ // initialize the plugin
        rules: {
        	airline_id: {
                required: true,
                integer: true
            },
            airline_name: {
            	required: true,
            	lettersonly: true
            },
            headquarters: {
            	required: true,
            	lettersonly: true
            },
            hq_city: {
            	required: true,
            	lettersonly: true
            },
            hq_country: {
            	required: true,
            	lettersonly: true
            },
            airport_hub: {
            	required: true,
            	lettersonly: true,
            	nowhitespace: true
            }
        }
    });

});

	$("#formSubmit").click(function() {
		if($('#insertairline').valid()){
	var airline_id = $("#airline_id").val();
	var airline_name = $("#airline_name").val();
	var headquarters = $("#headquarters").val();	
	var hq_city = $("#hq_city").val();
	var hq_country = $("#hq_country").val();
	var airport_hub = $("#airport_hub").val();
	
	var airline = new Object();
	airline.airline_id = airline_id;
	airline.airline_name = airline_name;
	airline.headquarters = headquarters;
	airline.hq_city = hq_city;
	airline.hq_country = hq_country;
	airline.airport_hub = airport_hub;
	
	var mydata =  JSON.stringify(airline);

			$.ajax({
				type : "POST",
				url : "airline",
				dataType : "json",
				data : mydata,
				contentType : 'application/json',
				mimeType : 'application/json',
				success : function(data) {
									
					document.getElementById('responsediv').style.display = 'block';
					document.getElementById("insertairline").reset();
					//alert("Insertion successful");
					},
					error: function( data, status, error ) { 
		         
		                alert("Insertion not successful");
		            }
					});
			return false;
			}
	});
</script>    
	
	
	
	
	
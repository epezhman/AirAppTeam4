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
      	<form id="insertairport" class="form-horizontal">

        <legend>Enter new airport</legend>

        <div class="control-group">
            <label class="control-label">Airport ID</label>
            <div class="controls">
                <div class="input-prepend">
                <span class="add-on"><i class="icon-user"></i></span>
                    <input type="text" class="input-xlarge"
									id="airportid" name="airportid" placeholder="airportid">
                </div>
            </div>
        </div>
        <div class="control-group ">
            <label class="control-label">Name</label>
            <div class="controls">
                <div class="input-prepend">
                <span class="add-on"><i class="icon-user"></i></span>
                    <input type="text" class="input-xlarge"
									id="name" name="name" placeholder="name">
                </div>
            </div>
        </div>

        <div class="control-group">
        <label class="control-label">City</label>
	    <div class="controls">
		<div class="input-prepend">
        <span class="add-on"><i class="icon-envelope"></i></span>
		<input type="text" class="input-xlarge" id="city"
									name="city" placeholder="city">
        </div>
		 </div>
	</div>
	  <div class="control-group">
        <label class="control-label">Country</label>
	    <div class="controls">
		<div class="input-prepend">
        <span class="add-on"><i class="icon-envelope"></i></span>
		<input type="text" class="input-xlarge" id="country"
									name="country" placeholder="country">
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
     <script src="./resources/js/jquery.validate.js"></script> 
    <script src="./resources/js/additional-methods.js">	</script>
	<script>
	// data array
	
	$(document).ready(function () {

    $('#insertairport').validate({ // initialize the plugin
        rules: {
        	airportid: {
                required: true,
                lettersonly: true,
                nowhitespace: true
            },
            name: {
            	required: true,
            	lettersonly: true
            },
            city: {
            	required: true,
            	lettersonly: true
            },
            country: {
            	required: true,
            	lettersonly: true
            }
        }
    });

});
	
	$("#formSubmit").click(function() {
		if($('#insertairport').valid()){
	var airportid = $("#airportid").val();
	var name = $("#name").val();
	var city = $("#city").val();	
	var country = $("#country").val();
	
	var airport = new Object();
	airport.airportid = airportid;
	airport.name = name;
	airport.city = city;
	airport.country = country;
	
	var mydata =  JSON.stringify(airport);
	

			$.ajax({
				type : "POST",
				dataType : "json",
				url : "airport",
				dataType : "json",
			
				data : mydata,
				contentType : 'application/json',
				mimeType : 'application/json',
				success : function(data) {
					
					document.getElementById('responsediv').style.display = 'block';
					document.getElementById("insertairport").reset();
					//alert("Insertion successful");
					},
					error: function( data, status, error ) { 
		                //console.log(data);
		                //console.log(status);
		                //console.log(error);
		                alert("Insertion not successful");
		            }
					});
			return false;
	
	}
		
	});
</script>    
	
	</jsp:attribute>
</t:genericpage>
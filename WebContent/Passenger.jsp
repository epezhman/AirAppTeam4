<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Search Flight</title>

	<script src="./resources/js/jquery-1.11.3.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.js"></script>
	<script src="./resources/js/bootstrap.min.js"></script> 
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="./resources/css/custom.css" rel="stylesheet">
  <script>

  function getPassengerDetails(){
	  
	  var firstName = $("#firstName").val();
	  var lastName = $("#lastName").val();
	  var address = $("#address").val();
	  var nationality = $("#nationality").val();
	  var gender = $('#gender').val();
	  var passengerType = $('#passengerType').val();
	  var phoneNumber = $('#phoneNumber').val();
	  var country = $('#country').val();
	  
		//prepare post data
		var dataString= "firstName="+firstName+"&lastName="+lastName+"&address="+address+"&nationality="+nationality+
						"&gender="+gender+"&passengerType="+passengerType+"&phoneNumber="+phoneNumber+"&country="+country;

		
		if (firstName == '' || lastName ==''){
			alert(" Please Enter valid names ");
		}else if(address == '') {
			alert("Please Enter valid address");
		}else if(nationality == '' ){
			alert("Please Enter valid Nationality");
		}else if(phoneNumber == ''){
			alert("Please Enter valid phone number ");
		}else if(country == ''){
			alert("Please Enter valid Country ");
		}else{
			$.ajax({
				type: "POST",
				dataType: "text", 
				url: "passenger",
				data: dataString,

				cache: false,
				success: function(responseObj) {
					if (responseObj == 'true'){
						/* var messageDiv = document.getElementById("message");
						messageDiv.style.display = 'block'; */
						window.location.href="ticket";
					}
				}
			});
			return false;
		}
  }
  </script>
</head>

<body>
	<nav class="navbar navbar-fixed-top navbar-inverse">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="./home.html">Air App</a>
			</div>
			<div id="navbar" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="./home.html">Home</a></li>
					<li><a href="./sample">Sample</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div>
        <div   class="col-sm-4"><!-- style="width:800px; margin:0 auto;"  -->
          <div style="width:800px; margin:0 auto;" class="panel panel-primary">
            <div class="panel-heading">
              <h3 class="panel-title">Passenger Details</h3>
            </div>
            <div class="panel-body">
            <table>
            	<tr>
            		<td><label>Last Name: </label><input id="lastName"></td>
            		<td><label >First Name: </label><input  id="firstName"></td>
            	</tr>
            	<tr></tr>
            	<tr></tr>
            	<tr>
   		     		<td><label>Address:</label><input type="text" id="address"/></td>
		     		<td><label>Contact :</label><input type="text" id="phoneNumber"/></td>
            		<td></td>
            	</tr>
            	<tr>
          	  		<td><label>Gender</label>
          			<select id="gender">
						<option value="male">Male</option>
						<option value="female">Female</option>
					</select>
 					</td>
           			<td><label>Nationality: </label><input id="nationality"></td>
             	</tr>
           	 	<tr>
          			<td><label>Passenger Type: </label><input id="passengerType"></td>
          	  		<td><label>Country</label>
          			<select id="country">
	          			<%
	          				String[] locales = Locale.getISOCountries();
	          			    for (String countryCode : locales) {
	          			     Locale obj = new Locale("", countryCode);
	          			%>	
	 					<option value="<%=obj.getDisplayCountry()%>"><%=obj.getDisplayCountry()%></option>
						<% }%>
					</select>
 					</td>
             	</tr>
            	<tr>
            		<td></td>
            		<td></td>
            		
            		<td>
            			<button type="button" class="btn btn-primary" onClick="getPassengerDetails()">Book Flight</button>
            		</td>
            	</tr>
            </table>
	 			</div>
            </div>
          </div>
	</div>
	<div style="display:none;" id="message" class="alert alert-success">
        <strong>Flight booked successfully </strong>
     </div>
</body>
</html>

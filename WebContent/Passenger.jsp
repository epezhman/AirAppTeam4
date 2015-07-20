<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Passenger Info</title>

<script src="./resources/js/jquery-1.11.3.js"></script>
<script src="./resources/js/jquery-ui.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>

<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
<link href="./resources/css/jquery-ui.min.css" rel="stylesheet">
<link href="./resources/css/custom.css" rel="stylesheet">


<script>
	function getPassengerDetails() {

		var firstName = $("#firstName").val();
		var lastName = $("#lastName").val();
		var address = $("#address").val();
		var nationality = $("#nationality").val();
		var gender = $('#gender').val();
		var passengerType = $('#passengerType').val();
		var phoneNumber = $('#phoneNumber').val();
		var country = $('#country').val();

		//prepare post data
		var dataString = "firstName=" + firstName + "&lastName=" + lastName
				+ "&address=" + address + "&nationality=" + nationality
				+ "&gender=" + gender + "&passengerType=" + passengerType
				+ "&phoneNumber=" + phoneNumber + "&country=" + country;

		if (firstName == '' || lastName == '') {
			alert(" Please Enter valid names ");
		} else if (address == '') {
			alert("Please Enter valid address");
		} else if (nationality == '') {
			alert("Please Enter valid Nationality");
		} else if (phoneNumber == '') {
			alert("Please Enter valid phone number ");
		} else if (country == '') {
			alert("Please Enter valid Country ");
		} else {
			$.ajax({
				type : "POST",
				dataType : "text",
				url : "passenger",
				data : dataString,

				cache : false,
				success : function(responseObj) {
					if (responseObj == 'true') {
						window.location.href = "ticket";
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
				<!-- <li><a href="./sample">Sample</a></li> -->
				<li><a href="./check_in">CheckIn</a></li>
				<li role="presentation" class="dropdown"><a
					class="dropdown-toggle" data-toggle="dropdown" href="#"
					role="button" aria-haspopup="true" aria-expanded="false">
						Insert <span class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="./airport.jsp">Airport</a></li>
						<li><a href="./airline.jsp">Airline</a></li>
						<li><a href="./airplane.jsp">Airplane</a></li>
						<li><a href="./flight_segment.jsp">Flight Segment</a></li>

					</ul></li>
			</ul>
		</div>
	</div>
	</nav>

	<div class="container main">

		<div class="well well-lg">
			<h3>Passenger Details</h3>

			<div class="row form-inline">
				<div class="col-md-2">
					<div class="form-group">
						<label>Last Name </label>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<input id="lastName" class="form-control">
					</div>
				</div>
				<div class="col-md-2">
					<div class="form-group">
						<label>First Name </label>
					</div>

				</div>
				<div class="col-md-4">
					<div class="form-group">
						<input id="firstName" class="form-control">
					</div>

				</div>
			</div>

			<div class="row form-inline">
				<div class="col-md-2">
					<div class="form-group">
						<label>Address </label>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<input id="address" class="form-control">
					</div>
				</div>
				<div class="col-md-2">
					<div class="form-group">
						<label>Contact </label>
					</div>

				</div>
				<div class="col-md-4">
					<div class="form-group">
						<input id="phoneNumber" class="form-control">
					</div>

				</div>
			</div>

			<div class="row form-inline">
				<div class="col-md-2">
					<div class="form-group">
						<label>Passenger Type </label>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<input id="passengerType" class="form-control">
					</div>
				</div>
				<div class="col-md-2">
					<div class="form-group">
						<label>Nationality </label>
					</div>

				</div>
				<div class="col-md-4">
					<div class="form-group">
						<input id="nationality" class="form-control">
					</div>

				</div>
			</div>

			<div class="row form-inline">
				<div class="col-md-2">
					<div class="form-group">
						<label>Gender </label>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<select id="gender" class="form-control">
							<option value="male">Male</option>
							<option value="female">Female</option>
						</select>
					</div>
				</div>
				<div class="col-md-2">
					<div class="form-group">
						<label>Nationality </label>
					</div>

				</div>
				<div class="col-md-4">
					<div class="form-group">
						<select id="country" class="form-control">
							<%
								String[] locales = Locale.getISOCountries();
								for (String countryCode : locales) {
									Locale obj = new Locale("", countryCode);
							%>
							<option value="<%=obj.getDisplayCountry()%>"><%=obj.getDisplayCountry()%></option>
							<%
								}
							%>
						</select>
					</div>

				</div>
			</div>

			<div class="row">
				<div class="col-md-2 col-md-offset-8">
					<button type="button" class="btn btn-primary"
						onClick="getPassengerDetails()">Book Flight</button>
				</div>
			</div>


		</div>
		<div style="display: none;" id="message" class="alert alert-success">
			<strong>Flight booked successfully </strong>
		</div>
	</div>
</body>
</html>

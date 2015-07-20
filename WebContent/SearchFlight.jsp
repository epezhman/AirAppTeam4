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
<title>Search Flight</title>


<script src="./resources/js/jquery-1.11.3.js"></script>
<script src="./resources/js/jquery-ui.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>

<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
<link href="./resources/css/jquery-ui.min.css" rel="stylesheet">
<link href="./resources/css/custom.css" rel="stylesheet">

<%
	ServletContext sc = request.getServletContext();
	String cities = (String) sc.getAttribute("cities");
%>
<script>
	$(function() {
		var availableTags =
<%=cities%>
	;

		$("#from").autocomplete({
			source : availableTags
		});
		$("#to").autocomplete({
			source : availableTags
		});
		$("#fromDate").datepicker({
			dateFormat : 'yy-mm-dd'
		});
		$("#toDate").datepicker({
			dateFormat : 'yy-mm-dd'
		});
	});

	function searchFlights() {
		var from = $("#from").val();
		var to = $("#to").val();
		var fromDate = $("#fromDate").val();
		var toDate = $("#toDate").val();
		var ticket = $('#ticketClass').val();
		var isOneway = $('#oneway').is(':checked');
		var noofPass = $('#noofPass').val();

		$('#one-flight-caption').text(from + ' --> ' + to);
		$('#two-flight-caption').text(to + ' --> ' + from);
		$('#one-flight-container').show();
		if (!isOneway)
			$('#two-flight-container').show();
		else
			$('#two-flight-container').hide();

		var dataString = "from=" + from + "&to=" + to + "&fromDate=" + fromDate
				+ "&toDate=" + toDate + "&ticketClass=" + ticketClass
				+ "&isOneway=" + isOneway + "&noofPass=" + noofPass;

		if (from == '') {
			alert(" Please select Departure City ");
		} else if (to == '') {
			alert("Please select Destination City");
		} else if (fromDate == '') {
			alert("Please select Departure Date");
		} else if (!isOneway && toDate == '') {
			alert("Please select Return Date ");
		} else {
			$.ajax({
				type : "POST",
				dataType : "json",
				url : "searchFlight",
				data : dataString,

				cache : false,
				success : function(responseObj) {
					arr = new Array();
					var parseObj = JSON.stringify(responseObj);
					arr = JSON.parse(parseObj);
					if (arr.length != 0) {
						displayFlights(arr);
					} else {
						$("#flights-continer").hide();
					}
				}
			});
			return false;

		}
	}

	function deleteRow(tableID) {
		try {
			var table = document.getElementById(tableID);
			var rowCount = table.rows.length;

			for (var i = 0; i < rowCount; i++) {
				var row = table.rows[i];
				table.deleteRow(row);
				rowCount--;
				i--;
			}
		} catch (e) {
			alert(e);
		}
	}

	function userSelectedFlights(arr) {

		var dataline = new Array();
		dataline = arr.split('|');

		var dataString = "departure_time=" + dataline[0] + "&arrival_time="
				+ dataline[1] + "&airplane_type=" + dataline[2]
				+ "&airline_name=" + dataline[3] + "&airport_destination_name="
				+ dataline[4] + "&airport_destination_city=" + dataline[5]
				+ "&airport_departure_name=" + dataline[6]
				+ "&airport_departure_city=" + dataline[7] + "&flight_price="
				+ dataline[8] + "&flight_number=" + dataline[9];
		$.ajax({
			type : "POST",
			dataType : "json",
			url : "selectedFlight",
			data : dataString,

			cache : false,

		});
		return false;

	}

	function displayFlights(arr) {

		var tr, tableBody_one, tableBody_two, table_one, table_two, trHeader, tdHeader, trFlightDetailsHeader;

		table_one = document.getElementById("one-flight");
		table_two = document.getElementById("two-flight");

		table_one.setAttribute("class", "table table-bordered");
		table_two.setAttribute("class", "table table-bordered");

		deleteRow("one-flight");
		deleteRow("two-flight");

		tableBody_one = document.createElement('TBODY');
		tableBody_two = document.createElement('TBODY');

		table_one.appendChild(tableBody_one);
		table_two.appendChild(tableBody_two);

		$("#flights-continer").show();

		for (var i = 0; i < arr.length; i++) {

			departure_time = arr[i].departure_time;
			arrival_time = arr[i].arrival_time;
			airplane_type = arr[i].airplane.airplane_type;
			airline_name = arr[i].airline.airline_name;
			airport_destination_name = arr[i].airport_destination.name;
			airport_destination_city = arr[i].airport_destination.city;
			airport_departure_name = arr[i].airport_departure.name;
			airport_departure_city = arr[i].airport_departure.city;
			flight_price = arr[i].price;
			flight_number = arr[i].flight_number;

			trHeader = document.createElement('TR');
			tdHeader = document.createElement('TD');
			tdHeader.appendChild(document
					.createTextNode(arr[i].airport_departure.city + " to "
							+ arr[i].airport_destination.city));
			trHeader.appendChild(tdHeader);

			tdHeaderPic = document.createElement('TD');

			var oImg = document.createElement("img");
			oImg.setAttribute('src', './resources/imgs/' + airline_name
					+ '.png');
			oImg.setAttribute('alt', 'na');
			oImg.style.width = '70px';
			oImg.style.height = '70px';

			tdHeaderPic.appendChild(oImg);
			trHeader.appendChild(tdHeaderPic);

			createFlightHeader(trFlightDetailsHeader);

			radioBtn = document.createElement("input");
			radioBtn.setAttribute("type", "radio");
			radioBtn.setAttribute("id",i);
			radioBtn.setAttribute("name", "flightSelection"+i);
			radioBtn.setAttribute("value",departure_time+"|"+arrival_time+"|"
			+airplane_type+"|"+	airline_name+"|"+airport_destination_name +"|"+airport_destination_city +"|"+	
			airport_departure_name+"|"+airport_departure_city+"|"+flight_price+"|"+flight_number
			);
			radioBtn.onclick = function(){
				userSelectedFlights(this.value);				
			};

			tr = document.createElement('TR');

			tdradioBtn = document.createElement('TD');
			tdradioBtn.appendChild(radioBtn);
			tr.appendChild(tdradioBtn);

			tdDepartTime = document.createElement('TD');
			tdDepartTime.appendChild(document.createTextNode(departure_time));
			tr.appendChild(tdDepartTime);

			tdArrivalTime = document.createElement('TD');
			tdArrivalTime.appendChild(document.createTextNode(arrival_time));
			tr.appendChild(tdArrivalTime);

			tdAirportDep = document.createElement('TD');
			tdAirportDep.appendChild(document
					.createTextNode(airport_departure_name));
			tr.appendChild(tdAirportDep);

			tdAirportDes = document.createElement('TD');
			tdAirportDes.appendChild(document
					.createTextNode(airport_destination_name));
			tr.appendChild(tdAirportDes);

			tdAirlineName = document.createElement('TD');
			tdAirlineName.appendChild(document.createTextNode(airline_name));
			tr.appendChild(tdAirlineName);

			tdAirplaneType = document.createElement('TD');
			tdAirplaneType.appendChild(document.createTextNode(airplane_type));
			tr.appendChild(tdAirplaneType);

			tdFlightNumber = document.createElement('TD');
			tdFlightNumber.appendChild(document.createTextNode(flight_number));
			tr.appendChild(tdFlightNumber);

			tdFlightPrice = document.createElement('TD');
			tdFlightPrice.appendChild(document.createTextNode(flight_price
					+ ' €'));
			tr.appendChild(tdFlightPrice);

			if (arr[i].which_way == "1") {
				tableBody_one.appendChild(trHeader);
				tableBody_one
						.appendChild(createFlightHeader(trFlightDetailsHeader));
				tableBody_one.appendChild(tr);
			} else {
				tableBody_two.appendChild(trHeader);
				tableBody_two
						.appendChild(createFlightHeader(trFlightDetailsHeader));
				tableBody_two.appendChild(tr);
			}

		}

	}

	function createFlightHeader(trFlightDetailsHeader) {
		trFlightDetailsHeader = document.createElement('TR');
		var headerFlihgt = new Array();
		headerFlihgt.push("", "Deaprt Time", "Arrival Time", "Depart Airport",
				"Arrival Airport", "Airline", "Airplane", "Flight Number",
				"Price");
		for (var i = 0; i < headerFlihgt.length; i++) {
			td = document.createElement('TD');
			td.appendChild(document.createTextNode(headerFlihgt[i]));
			trFlightDetailsHeader.appendChild(td);
		}
		return trFlightDetailsHeader;
	}

	function callPassengerJSP() {
		window.location.href = "Passenger.jsp";
	}

	function checkIsOneway() {
		var isChecked = $('#oneway').is(':checked');
		if (isChecked == true) {
			$("#toDate").datepicker('disable');
		} else {
			$("#toDate").datepicker('enable');
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
				<a class="navbar-brand" href="./SearchFlight.jsp"> <span class="glyphicon glyphicon-plane" aria-hidden="true"></span> Air App Team 4</a>
			</div>
			<div id="navbar" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="./SearchFlight.jsp">Book a Flight</a></li>
					<li><a href="./check_in">Check In Online!</a></li>
					<li><a href="./clearance">Runway Clearance</a></li>
					<li><a href="./search_passenger.jsp">Search Passenger</a></li>
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

		<div class="jumbotron">
			<h1> <span class="glyphicon glyphicon-plane" aria-hidden="true"></span> Air Traffic App Team 4</h1>
		</div>

		<div class="well well-lg">

			<h3> <span class="glyphicon glyphicon-search" aria-hidden="true"></span> Search Flight</h3>

			<div class="row form-inline">
				<div class="col-md-1">
					<div class="form-group">
						<label>From </label>
					</div>
				</div>
				<div class="col-md-5">
					<div class="form-group">
						<input id="from" class="form-control">
					</div>
				</div>
				<div class="col-md-1">
					<div class="form-group">
						<label>To </label>
					</div>

				</div>
				<div class="col-md-5">
					<div class="form-group">
						<input id="to" class="form-control">
					</div>
					<div class="checkbox">
						<label> <input type="checkbox" id="oneway"
							onClick="checkIsOneway()">One Way
						</label>
					</div>
				</div>
			</div>


			<div class="row form-inline">
				<div class="col-md-1">
					<div class="form-group">
						<label>Departure </label>
					</div>
				</div>
				<div class="col-md-5">
					<div class="form-group">
						<input id="fromDate" name="fromDate" class="form-control">
					</div>
				</div>
				<div class="col-md-1">
					<div class="form-group">
						<label>Return </label>
					</div>

				</div>
				<div class="col-md-5">
					<div class="form-group">
						<input id="toDate" name="toDate" class="form-control">
					</div>

				</div>
			</div>

			<div class="row form-inline">
				<div class="col-md-1">
					<div class="form-group">
						<label>Ticket </label>
					</div>
				</div>
				<div class="col-md-5">
					<div class="form-group">
						<select id="ticketClass" class="form-control">
							<option value="Economy">Economy</option>
							<option value="Business">Business</option>
						</select>
					</div>
				</div>
				<div class="col-md-1">
					<div class="form-group">
						<label>Passengers</label>
					</div>

				</div>
				<div class="col-md-5">
					<div class="form-group">
						<select id="noofPass" class="form-control">
							<%
								for (int i = 1; i <= 10; i++) {
							%>
							<option value="<%=i%>"><%=i%></option>
							<%
								}
							%>
						</select>
					</div>

				</div>
			</div>
			<div class="row">
				<div class="col-md-2 col-md-offset-9">
					<button type="button" class="btn btn-primary"
						onClick="searchFlights()">Search Flight</button>
				</div>
			</div>


		</div>
		<div style="display: none;" id="message" class="alert alert-danger">
			<strong> No Flights found for your search </strong>
		</div>

		<div style="display: none" id="flights-continer">

			<div style="display: none" id="one-flight-container">
				<p id="one-flight-caption" class="bg-info" style="padding: 10px"></p>
				<table border='1' id="one-flight">

				</table>
			</div>
			<div style="display: none" id="two-flight-container">
				<p id="two-flight-caption" class="bg-info" style="padding: 10px"></p>
				<table border='1' id="two-flight">

				</table>
			</div>
			<button type="button" class="btn btn-primary"
				onClick="callPassengerJSP()">Proceed</button>

		</div>
	</div>
</body>
</html>
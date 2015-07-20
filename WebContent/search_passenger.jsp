
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>	
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="./resources/js/jquery-1.11.3.js"></script>
<script src="./resources/js/jquery-ui.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>

<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
<link href="./resources/css/jquery-ui.min.css" rel="stylesheet">
<link href="./resources/css/custom.css" rel="stylesheet">

<script>
function ali(){
	alert("ali");
}
function searchPassenger(){
	
	var ticket = $('#ticketNumber').val();
	var dataString = "ticketNumber="+ticket;
	alert(dataString);
	$.ajax({
			type : "POST",
			dataType : "json",
			url : "searchPassengerServlet",
			data : dataString,

			cache : false,
			success : function(responseObj) {
				var arr = new Array();
				var parseObj = JSON.stringify(responseObj);
				arr = JSON.parse(parseObj);
				//alert(arr);
				if (arr.length != 0) {
					displaySearch(arr);
				}else{
					alert("no data");
				}
			}
		});
		return false;

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

 function displaySearch(arr) {
	debugger;
	alert(arr.length);
   var tr, table, trSearchHeader,tableBody;

	table = document.getElementById("search_passenger");

	table.setAttribute("class", "table table-bordered");

	deleteRow("search_passenger");

	tableBody= document.createElement('TBODY');

	table.appendChild(tableBody);
	//table.appendChild(tableBody_two);


	for (var j = 0; j <arr.length; j++) {

		first_name = arr[j].first_name;
		last_name = arr[j].last_name;
		gender = arr[j].gender;
		nationality = arr[j].nationality;


		//trHeader = document.createElement('TR');
		//tdHeader = document.createElement('TD');

		//createSearchHeader(trSearchHeader);
		
		tr = document.createElement('TR');
		
		tdfname = document.createElement('TD');
		tdfname.appendChild(document.createTextNode(first_name));
		tr.appendChild(tdfname);

		tdlast_name= document.createElement('TD');
		tdlast_name.appendChild(document.createTextNode(last_name));
		tr.appendChild(tdlast_name);
		
		tdgender= document.createElement('TD');
		tdgender.appendChild(document.createTextNode(gender));
		tr.appendChild(tdgender);
		
		tdnationality= document.createElement('TD');
		tdnationality.appendChild(document.createTextNode(nationality));
		tr.appendChild(tdnationality);
		
		//table.appendChild(trHeader);
		table.appendChild(createSearchHeader(trSearchHeader));
		table.appendChild(tr);

	}

}

function createSearchHeader(trSearchHeader) {
	trSearchHeader = document.createElement('TR');
	var headerFlihgt = new Array();
	headerFlihgt.push("First Name", "Last Name", "Gender",
			"Nationality");
	for (var i = 0; i < headerFlihgt.length; i++) {
		td = document.createElement('TD');
		td.appendChild(document.createTextNode(headerFlihgt[i]));
		trSearchHeader.appendChild(td);
	}
	return trSearchHeader;
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
			<a class="navbar-brand" href="./home.html"> Air App</a>
		</div>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<li><a href="./home.html">Home</a></li>
				<li><a href="./sample">Sample</a></li>
				<li><a href="./check_in">CheckIn</a></li>
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
		<div class="well well-lg">
			<h3>Search Passenger</h3>
				<div class="row form-inline">
					<div class="col-md-2">
						<div class="form-group">
							<label>Ticket Number</label>
						</div>
					</div>
					<div class="col-md-5">
						<div class="form-group">
							<input id="ticketNumber" class="form-control">
						</div>
					</div>
					<div class="row">
						<div class="col-md-5">
							<button type="button" class="btn btn-primary" onClick="searchPassenger()">Search Flight</button>
						</div>
					</div>
				</div>
			</div>
			<div>
				<table border='1' id="search_passenger">
				</table>
			</div>
	</div>
	
</body>
</html>
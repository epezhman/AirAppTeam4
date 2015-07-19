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

<!-- 	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>-->
<!-- 	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>  -->
	<script src="./resources/js/jquery-1.11.3.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.js"></script>
   
	<script src="./resources/js/bootstrap.min.js"></script> 
	<link href="./resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="./resources/css/custom.css" rel="stylesheet">
	
	
    
	<%
	ServletContext sc = request.getServletContext();
	String cities = (String)sc.getAttribute("cities");
//	out.print(cities);
	%>
	  <script>
  $(function() {
	  var availableTags =  <%=cities%>; //new Array();
		//  availableTags.push("ali");
	 // alert(availableTags);
	
    $( "#from" ).autocomplete({
      source: availableTags
    });
    $( "#to" ).autocomplete({
        source: availableTags
      });
	$("#fromDate").datepicker({
		dateFormat: 'yy-mm-dd'
	});
	$("#toDate").datepicker({
		dateFormat: 'yy-mm-dd'
	});
   
  });
  
  
  
  function searchFlights(){
	  var from = $("#from").val();
	  var to = $("#to").val();
	  var fromDate = $("#fromDate").val();
	  var toDate = $("#toDate").val();
	  var ticket = $('#ticketClass').val();
	  var isOneway = $('#oneway').is(':checked');
	  var noofPass = $('#noofPass').val();
	  
	//  alert("from "+from+"to "+to+"fromDate "+fromDate+"toDate "+toDate+"ticket "+ticket+"isOneway "+isOneway
		//	  +"noofPass "+noofPass);
	  
		//prepare post data
		var dataString= "from="+from+"&to="+to+"&fromDate="+fromDate+"&toDate="+toDate+
						"&ticketClass="+ticketClass+"&isOneway="+isOneway+"&noofPass="+noofPass;
		
		if (from == ''){
			alert(" Please select Departure City ");
		}else if(to == '') {
			alert("Please select Destination City");
		}else if(fromDate == '' ){
			alert("Please select Departure Date");
		}else if(!isOneway && toDate == ''){
			alert("Please select Return Date ");
		}else{
			$.ajax({
				type: "POST",
				dataType: "json", 
				url: "searchFlight",
				data: dataString,

				cache: false,
				success: function(responseObj) {
					//responseObj holds data in json format from server
					// we need to parse json
					arr = new Array();
					var parseObj = JSON.stringify(responseObj);
					//in arr we get json
					arr = JSON.parse(parseObj);
					
					if (arr.length == 0){
						//alert("No Flights found for your search");
						//var messageDiv = document.getElementById("message");
						//messageDiv.style.display = 'block';
						
					}else{
						displayFlights(arr);
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

      for(var i=0; i<rowCount; i++) {
          var row = table.rows[i];
              table.deleteRow(row);
              rowCount--;
              i--;
        }
      }catch(e) {
          alert(e);
      }
  }
  
  
  function displayFlights(arr){

	  var tr,tableBody,table,trHeader,tdHeader,trFlightDetailsHeader;
	  
	  table = document.getElementById("flight");
	  table.setAttribute("class", "table table-bordered");
	  deleteRow("flight");
	  tableBody = document.createElement('TBODY');
	  table.appendChild(tableBody);

	   
	   for ( var i=0; i<arr.length; i++){
		     
			departure_time = arr[i].departure_time;
			arrival_time = arr[i].arrival_time;
			airplane_type = arr[i].airplane.airplane_type;
			airline_name = arr[i].airline.airline_name;
			airport_destination_name = arr[i].airport_destination.name;
			airport_destination_city = arr[i].airport_destination.city;
			airport_departure_name = arr[i].airport_departure.name; 
			airport_departure_city = arr[i].airport_departure.city;
			
			trHeader  = document.createElement('TR');
			tdHeader = document.createElement('TD');
			tdHeader.appendChild(document.createTextNode(arr[i].airport_departure.city + " to "+arr[i].airport_destination.city));
			trHeader.appendChild(tdHeader);
			
			createFlightHeader(trFlightDetailsHeader);
			
			//Create an input type dynamically.
		    var radioBtn = document.createElement("input");
		    radioBtn.setAttribute("type", "radio");
		    radioBtn.setAttribute("name", "flightSelection"+i);
		   // radioBtn.setAttribute("value", "true");
		  //  radioBtn.setAttribute("label", "PLease Select ");
			//radioBtn.
		    
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
			
			tdAirportDep= document.createElement('TD');
			tdAirportDep.appendChild(document.createTextNode(airport_departure_name));
			tr.appendChild(tdAirportDep);
			
			tdAirportDes= document.createElement('TD');
			tdAirportDes.appendChild(document.createTextNode(airport_destination_name));
			tr.appendChild(tdAirportDes);
			
			tdAirlineName = document.createElement('TD');
			tdAirlineName.appendChild(document.createTextNode(airline_name));
			tr.appendChild(tdAirlineName);
			
			tdAirplaneType = document.createElement('TD');
			tdAirplaneType.appendChild(document.createTextNode(airplane_type));
			tr.appendChild(tdAirplaneType);
	
			tableBody.appendChild(trHeader);
			tableBody.appendChild(createFlightHeader(trFlightDetailsHeader));
			tableBody.appendChild(tr);
	   }
	  
  }
  
  function createFlightHeader(trFlightDetailsHeader){
	   trFlightDetailsHeader = document.createElement('TR');
	   var headerFlihgt = new Array();
	   headerFlihgt.push("","Deaprt Time","Arrival Time","Depart Airport","Arrival Airport","Airline","Airplane");
	   for (var i=0; i<headerFlihgt.length; i++){
		    td = document.createElement('TD');
		   // td.setAttribute("font-weight", "bold");
		    td.appendChild(document.createTextNode(headerFlihgt[i]));
		    trFlightDetailsHeader.appendChild(td);
	   }
	   return trFlightDetailsHeader;
  }
  
  function callPassengerJSP(){
	  window.location.href = "Passenger.jsp";
  }
   
function checkIsOneway(){
	var isChecked = $('#oneway').is(':checked');
	if (isChecked == true){
		$("#toDate").datepicker('disable');
	}else{
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
              <h3 class="panel-title">Search Flight</h3>
            </div>
            <div class="panel-body">
            <table>
            	<tr>
            		<td><label>From: </label><input id="from"></td>
            		<td><label >To: </label><input  id="to"></td>
            		<td><input type="checkbox" id="oneway" onClick="checkIsOneway()">One Way </td>
            	</tr>
            	<tr></tr>
            	<tr></tr>
            	<tr>
            		<td><label for="fromDate">Departure</label><input type="text" id="fromDate" name="fromDate"/></td>
          			<td><label for="toDate">Return</label><input type="text" id="toDate" name="toDate"/></td>
            		<td></td>
            	</tr>
            	<tr>
            		<td><label>Ticket</label>
            			<select id="ticketClass">
	 						<option value="Economy">Economy</option>
	 						<option value="Business">Business</option>
	 					</select>
	  				</td>
	  				<td>
						<label>No of Passengers:</label>	  				
	  	  				 <select id="noofPass">
								<%  for (int i =1; i<=10; i++){ %>
			 						<option value="<%=i%>"><%=i%></option>
			 					<% }%>
						</select>
					</td>
            	</tr>
            	<tr>
            		<td></td>
            		<td></td>
            		
            		<td>
            			<button type="button" class="btn btn-primary" onClick="searchFlights()">Search Flight</button>
            		</td>
            	</tr>
            </table>
	     	<!--       <div class="ui-widget">
	 			</div>		
	 					<br><br>
	 					
						<br><br> -->
  			 	 
				</div>
            </div>
          </div>
	</div>
	<div style="display:none;" id="message" class="alert alert-danger">
        <strong> No Flights found for your search </strong>
      </div>
	<div>
		<table BORDER='1' id="flight">
		
		</table>
		<table>
				<tr ALIGN=RIGHT>
            		<td></td>
            		<td></td>
            		<td>
            			<button type="button" class="btn btn-primary" onClick="callPassengerJSP()">Proceed</button>
            		</td>
            	</tr>
		</table>
	</div>

</body>
</html>
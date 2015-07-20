<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@page import="de.tum.in.dbpra.model.bean.TicketBean"%>
<%@page import="de.tum.in.dbpra.model.bean.PassengerBean"%>
<%@page import="de.tum.in.dbpra.model.bean.FlightSegmentBean"%>
<jsp:useBean id="passenger" scope="session"
	class="de.tum.in.dbpra.model.bean.PassengerBean" />
<jsp:useBean id="ticket" scope="session"
	class="de.tum.in.dbpra.model.bean.TicketBean" />
<jsp:useBean id="flightselected" scope="session"
	class="de.tum.in.dbpra.model.bean.FlightSegmentBean" />

<t:genericpage>
	<jsp:attribute name="body">	
		<div class="container">
             <!-- <div class="well"> -->

                     <legend> Your Ticket</legend>
                    
                    <div id="responsediv" style="display: none">
                    <!-- the response in these label are coming from server -->
                    <div class="alert alert-success" role="alert">
                        Ticket generated.
                    </div>
                    </div>
                    <div class="col-md-7 well">
                    <table class="table table-condensed">
                    <thead><th>Ticket Details</th>
                    </thead>
                    <tbody>
                    <tr>
                    <td>Ticket ID</td>
                    <td>${ticket.getTicketId()}</td>
                    <td>&nbsp; </td>
                    <td>&nbsp; </td>
                   </tr>
                   <tr>
                    <td> Issued by </td>
                    
                    <td> ${ticket.getIssuedBy()} </td>
                    <td> Issued on </td>
                    <td> ${ticket.getIssuedOn()}</td>
                    </tr>
                    <tr>
                    <td> Valid From</td>
                    <td>${ticket.getValidFrom()}</td>
                    <td> Valid Till</td>
                    <td>${ticket.getValidTill()}</td>
                    </tr>
                    <tr>
                   <%--  <td> Ticket type</td>
                    <td> &nbsp; asd</td> --%>
                    <td> Price</td>
                    <td> ${ticket.getPrice()}Euro</td>
                    </tr>
                    </tbody>
                    </table>
                    <br>
                    <table class="table table-condensed">
                    <thead>
                    <th> Passenger Details</th>
                    </thead>
                    <tbody>
                    <tr>
                  <td>Last Name </td>
                  <td>${passenger.getLastName()} </td> 
                 
            		<td>First Name</td>
            		<td>${passenger.getFirstName()} </td>
                    </tr>
                       <tr>
                  <td>Address </td>
                  <td> ${passenger.getAddress()} </td> 
            		<td>Contact</td>
            		<td> ${passenger.getPhoneNumber()}</td>
                    </tr>
                    </tbody>
                    </table>
                    
                    <br>
                    <table class="table table-condensed">
                    <thead>
                    <th> Flight Details</th>
                    
                    </thead>
                    <tbody>
                    <tr><td>Flight Number</td><td>${flightselected.getFlightNumber() }
                    </td></tr>
                    <tr>
                  <td>From </td>
                  <td>${flightselected.getAirportDeparture().getAirportId()} </td> 
                 <td>Departure Date </td>
                  <td> ${flightselected.getDepartureTime()} </td> 
            		
                    </tr>
                       <tr>
                  
                  <td>To</td>
            		<td>${flightselected.getAirportDestination().getAirportId()} </td>
            		<td>Arrival Date</td>
            		<td> ${flightselected.getArrivalTime()}</td>
                    </tr>
                    </tbody>
                    </table>
                    <button type="button" class="btn btn-primary"
					>Print Ticket</button>
                    </div>
            </div>
        <!-- </div> -->

      </jsp:attribute>
</t:genericpage>






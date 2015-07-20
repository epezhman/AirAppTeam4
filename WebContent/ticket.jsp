<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List"%>
<%@page import="de.tum.in.dbpra.model.bean.TicketBean"%>
<%@page import="de.tum.in.dbpra.model.bean.PassengerBean"%>
<%@page import="de.tum.in.dbpra.model.bean.FlightSegmentBean"%>
<jsp:useBean id="passenger" scope="session"
	class="de.tum.in.dbpra.model.bean.PassengerBean" />
<jsp:useBean id="ticket" scope="session"
	class="de.tum.in.dbpra.model.bean.TicketBean" />

<c:set var="count" value="1" scope="page" />

<t:genericpage>
	<jsp:attribute name="body">	
		<div class="container">
             <div class="well well-lg">

                     <h3> <span class="glyphicon glyphicon-ok"
						aria-hidden="true"></span> Your Ticket Information</h3>
                    <div class="alert alert-success">
 								 Please either print or make a copy of Ticket Number.
					</div>
					
					<table class="table table-condensed">
						<caption> <strong><span class="glyphicon glyphicon-bookmark"
							aria-hidden="true"></span> Ticket Details</strong></caption>
                    
	                    <tbody>
		                    <tr>
			                    <td> <strong>Ticket ID</strong></td>
			                    <td>${ticket.getTicketId()}</td>
			                    <td><strong>Ticket Number</strong> </td>
			                    <td>${ticket.getTicket_number()} </td>
		                   </tr>
	                 	   <tr>
			                    <td> <strong>Issued by </strong></td>	                  
			                    <td> ${ticket.getIssuedBy()} </td>
			                    <td> <strong>Issued on</strong> </td>
			                    <td> ${ticket.getIssuedOn()}</td>
	                    	</tr>
	                    	<tr>
			                    <td><strong> Valid From</strong></td>
			                    <td>${ticket.getValidFrom()}</td>
			                    <td> <strong>Valid Till</strong></td>
			                    <td>${ticket.getValidTill()}</td>
		                    </tr>
		                    <tr>	                    
			                    <td> <strong>Price</strong></td>
			                    <td> ${ticket.getPrice()}Euro</td>
			                    <td colspan="2"> </td>
	                    	</tr>
	                    </tbody>
                    </table>
					
					<table class="table table-condensed">
						<caption><strong> <span class="glyphicon glyphicon-user"
							aria-hidden="true"></span>  Passenger Details</strong></caption>
                 
	                    <tbody>
		                    <tr>
				                <td><strong>Last Name</strong> </td>
				                <td>${passenger.getLastName()} </td>                  
				            	<td><strong>First Name</strong></td>
				            	<td>${passenger.getFirstName()} </td>
		                    </tr>
		                    <tr>
			                  	<td><strong>Address </strong></td>
			                  	<td> ${passenger.getAddress()} </td> 
			            	 	<td><strong>Contact</strong></td>
			            		<td> ${passenger.getPhoneNumber()}</td>
		                    </tr>
	                    </tbody>
                    </table>
                    
                    <h4>  <span class="glyphicon glyphicon-plane"
						aria-hidden="true"></span> Flight Details</h4>   
						                                    
	                    <c:forEach var="flightselected" items="${flights}">
	                    <table class="table table-condensed">
                   			<caption><strong>Flight ${count}</strong></caption>
		                    <thead>                                        								
								
						<tbody>
			                    	<tr>
										<td><strong>Flight Number</strong></td>
										<td>${flightselected.getFlightNumber() }</td>
										<td colspan="2"></td>
									</tr>
			                    	<tr>
					                  <td><strong>From </strong></td>
					                  <td>${flightselected.getAirportDeparture().getAirportId()} </td> 
					                  <td><strong>Departure Date</strong> </td>
					                  <td> ${flightselected.getDepartureTime()} </td>             		
			                   		</tr>
			                        <tr>                  
					                    <td><strong>To</strong></td>
					            		<td>${flightselected.getAirportDestination().getAirportId()} </td>
					            		<td><strong>Arrival Date</strong></td>
					            		<td> ${flightselected.getArrivalTime()}</td>
			                    	</tr>
	                    	  </tbody>
                 		   </table>
                 		   <c:set var="count" value="${count + 1}"
						scope="page" />
		                </c:forEach>	                  
                    <button type="button" class="btn btn-primary"
					onclick="window.print()">Print Ticket</button>                                       
            </div>
        </div>

      </jsp:attribute>
</t:genericpage>






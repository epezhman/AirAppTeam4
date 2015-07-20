<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	
<%@page import="de.tum.in.dbpra.model.bean.FlightControllerBean"%>
<%@page import="de.tum.in.dbpra.model.bean.FlightControllerContainerBean"%>

<jsp:useBean id="controllers" scope="request"
	class="de.tum.in.dbpra.model.bean.FlightControllerContainerBean" />

<%@page import="de.tum.in.dbpra.model.bean.AirportBean"%>
<%@page import="de.tum.in.dbpra.model.bean.AirportContainerBean"%>

<jsp:useBean id="airports" scope="request"
	class="de.tum.in.dbpra.model.bean.AirportContainerBean" />

<%@page import="de.tum.in.dbpra.model.bean.FlightSegmentBean"%>
<%@page import="de.tum.in.dbpra.model.bean.FlightSegmentContainerBean"%>

<jsp:useBean id="all_flights" scope="request"
	class="de.tum.in.dbpra.model.bean.FlightSegmentContainerBean" />
	
<c:set var="error" value="${requestScope.error}" scope="request" />

<t:genericpage>

	<jsp:attribute name="body">	
		<c:choose> 
		  <c:when test="${error != null}">
		    <h1>Error!</h1>
		    <c:out value="${error}" />
		  </c:when>
		  <c:otherwise>
		  		  <div class="well well-lg">
		  
		  	<h3> Runway Clearance </h3>
		  		           
			<form class="form-horizontal" id="clearance-form">
			  <div class="form-group">
			    <label for="input-ticket-number" class="col-sm-2 control-label">Airport</label>
			    <div class="col-sm-10">
				<select id="airport" class="form-control" required="required">
							 <c:forEach items="${airports.getBeanList()}" var="airport">
		        				<option value="${airport.getAirportId()}">${airport.getName()}</option>
		    				</c:forEach>
				</select>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="input-last-name" class="col-sm-2 control-label">Time of Clearance</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="input-clearance"
									placeholder="Time of Clearance" required="required">
			    </div>
			  </div>	
			 
			  <div class="form-group">
			    <label for="input-ticket-number" class="col-sm-2 control-label">Flight Segment</label>
			    <div class="col-sm-10">
				<select id="flight-segment" class="form-control" required="required">
							 <c:forEach items="${all_flights.getBeanList()}" var="flight">
		        				<option value="${flight.getFlightSegmentId()}">${flight.getAirportDeparture().getAirportId()} --> ${flight.getAirportDestination().getAirportId()}</option>
		    				</c:forEach>
				</select>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="input-ticket-number" class="col-sm-2 control-label">Flight Controller</label>
			    <div class="col-sm-10">
				<select id="controller" class="form-control" required="required">
							 <c:forEach items="${controllers.getBeanList()}" var="controller">
		        				<option value="${controller.getFlightControllerId()}">${controller.getEmployee().getFirstName()} ${controller.getEmployee().getLastName()}</option>
		    				</c:forEach>
				</select>
			    </div>
			  </div>
			  	
			  <div class="form-group">
			    <div class="col-sm-offset-10 col-sm-2">
			      <button type="submit" class="btn btn-primary"
									id="clearance-submit">Check Clearance</button>
			    </div>
			  </div>
			</form>
			
			
			<div id="clear-runways"></div>
				</div>				           		           		           		       
		  </c:otherwise>
		</c:choose>
				
    </jsp:attribute>
</t:genericpage>
<script>
	$(function() {
		$('#input-clearance').datetimepicker();
	});
</script>
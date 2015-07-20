<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="de.tum.in.dbpra.model.bean.BoardingPassBean"%>
<%@page import="de.tum.in.dbpra.model.bean.BoardingPassContainerBean"%>

<jsp:useBean id="passes" scope="request"
	class="de.tum.in.dbpra.model.bean.BoardingPassContainerBean" />
<c:set var="count" value="1" scope="page" />

<c:set var="error" value="${requestScope.error}" scope="request" />
<c:choose>
	<c:when test="${error != null}">
		<h1>Error!</h1>
		<c:out value="${error}" />
	</c:when>
	<c:otherwise>
		<h4>
			<span class="glyphicon glyphicon-road" aria-hidden="true"></span>
			Boarding Passes
		</h4>

		<c:forEach var="pass" items="${passes.getBeanList()}">
			<table class="table table-condensed">
				<caption>
					<strong>Flight ${count}</strong>
				</caption>
				<thead>
				<tbody>
					<tr>
						<td><strong>Boarding Pass Number</strong></td>
						<td>${pass.getBoardinPassNumber() }</td>
						<td><strong>Flight Number</strong></td>
						<td>${pass.getTicketFlightSegmentMapper().getFlightSegmen().getFlightNumber() }</td>
					</tr>
					<tr>
						<td><strong>Issued By</strong></td>
						<td>${pass.getIssuedBy() }</td>
						<td><strong>Issued On</strong></td>
						<td>${pass.getIssuedOn() }</td>
					</tr>
					<tr>
						<td><strong>Special Service</strong></td>
						<td>${pass.getSpecialService() }</td>
						<td><strong>Pass Gate</strong></td>
						<td>${pass.getPassGate() }</td>
					</tr>
					<tr>
						<td><strong>setSelectedSeat</strong></td>
						<td>${pass.getSelectedSeat() }</td>
						<td colspan="2"></td>
					</tr>
					<tr>
						<td><strong>Departure</strong></td>
						<td>${pass.getTicketFlightSegmentMapper().getFlightSegmen().getAirportDeparture().getCity()}
							- ${ pass.getTicketFlightSegmentMapper().getFlightSegmen().getAirportDeparture().getAirportId() }</td>
						<td><strong>Arrival</strong></td>
						<td>${pass.getTicketFlightSegmentMapper().getFlightSegmen().getAirportDestination().getCity()}
							- ${ pass.getTicketFlightSegmentMapper().getFlightSegmen().getAirportDestination().getAirportId() }</td>
					</tr>
					<tr>
						<td><strong>Departure Time</strong></td>
						<td>${pass.getTicketFlightSegmentMapper().getFlightSegmen().getDepartureTime() }</td>
						<td><strong>Arrival Time</strong></td>
						<td>${pass.getTicketFlightSegmentMapper().getFlightSegmen().getArrivalTime() }</td>
					</tr>
				</tbody>
			</table>
			<c:set var="count" value="${count + 1}" scope="page" />
		</c:forEach>
		<button type="button" class="btn btn-primary" onclick="window.print()">Print
			Boarding Passes</button>
	</c:otherwise>
</c:choose>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="de.tum.in.dbpra.model.bean.AirportBean"%>
<%@page import="de.tum.in.dbpra.model.bean.AirportContainerBean"%>

<jsp:useBean id="airports" scope="request"
	class="de.tum.in.dbpra.model.bean.AirportContainerBean" />

<%@page import="de.tum.in.dbpra.model.bean.SampleContainerBean"%>
<%@page import="de.tum.in.dbpra.model.bean.SampleBean"%>

<jsp:useBean id="samples" scope="request"
	class="de.tum.in.dbpra.model.bean.SampleContainerBean" />

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
		  		           
			<form class="form-horizontal" id="check-in-form">
			  <div class="form-group">
			    <label for="input-ticket-number" class="col-sm-2 control-label">Airport</label>
			    <div class="col-sm-10">
				<select id="airport" class="form-control" required="required">
							 <c:forEach items="${airports.getBeanList()}" var="airport">
		        				<option value="${airport.setAirportId()}">${airport.getName()}</option>
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
			    <div class="col-sm-offset-2 col-sm-10">
			      <button type="submit" class="btn btn-default"
									id="check-in-submit">Check Clearance</button>
			    </div>
			  </div>
			</form>
			<table class="table table-striped table-hover">
		  <caption>Samples</caption>
		  <thead>
		        <tr>
		          <th>#</th>
		          <th>ID</th>
		          <th>Name</th>		  
		        </tr>
		      </thead>
		    <tbody>
		    <c:forEach items="${samples.getBeanList()}" var="sample">
		        <tr>
		         	<td><c:out value="${count}" /></td>
		            <td><c:out value="${sample.getId()}" /></td>
		            <td><c:out value="${sample.getName()}" /></td>  
		        </tr>
		        <c:set var="count" value="${count + 1}" scope="page" />
		    </c:forEach>
		     </tbody>
		    </table>
			
			<div id="print-boarding-pass"></div>
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
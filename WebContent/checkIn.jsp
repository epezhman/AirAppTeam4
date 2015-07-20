<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="de.tum.in.dbpra.model.bean.SampleContainerBean"%>
<%@page import="de.tum.in.dbpra.model.bean.SampleBean"%>

<jsp:useBean id="samples" scope="request"
	class="de.tum.in.dbpra.model.bean.SampleContainerBean" />
<c:set var="count" value="1" scope="page" />

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
		  	<h3> <span class="glyphicon glyphicon-briefcase"
							aria-hidden="true"></span> Check In </h3>
		  
         	<div class="alert alert-info">In order to check in and print your boarding passes please enter your ticket number and your last name</div>
		           
			<form class="form-horizontal" id="check-in-form">
			  <div class="form-group">
			    <label for="input-ticket-number" class="col-sm-2 control-label">Ticket Number</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control"
									id="input-ticket-number" placeholder="Ticket Number"
									required="required">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="input-last-name" class="col-sm-2 control-label">Last Name</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="input-last-name"
									placeholder="Last Name" required="required">
			    </div>
			  </div>			
			  <div class="form-group">
			    <div class="col-sm-offset-10 col-sm-2">
			      <button type="submit" class="btn btn-primary"
									id="check-in-submit">Check In</button>
			    </div>
			  </div>
			</form>
					
			<div id="print-boarding-pass"></div>
		</div>				           		           		           		       
		  </c:otherwise>
		</c:choose>
				
    </jsp:attribute>
</t:genericpage>
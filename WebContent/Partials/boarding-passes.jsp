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
<c:choose>
	<c:when test="${error != null}">
		<h1>Error!</h1>
		<c:out value="${error}" />
	</c:when>
	<c:otherwise>
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

	</c:otherwise>
</c:choose>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<c:set var="count" value="1" scope="page" />

<c:set var="error" value="${requestScope.error}" scope="request" />

<c:set var="clear" value="${requestScope.clear}" scope="request" />

<c:choose>
	<c:when test="${clear}">
			<p class="bg-success" style="padding: 10px">Runway is Clear for use</p>
		</c:when>
		<c:otherwise>
			<p class="bg-danger" style="padding: 10px">For this time Runway is occupied.</p>
		</c:otherwise>
</c:choose>

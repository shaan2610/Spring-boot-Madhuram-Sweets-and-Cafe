<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<t:ordertemplate>
	<div class = "container m-4">
		<h1>What makes you hungry!! 😋😋</h1>
		<br>
		<h3>Please choose a category</h3>
		<hr/>
	</div>
	<div class="container">
	<div class="row">
		<c:forEach items="${categories}" var="ci" varStatus="loop">
			<c:if test="${loop.index % 2 == 0}">
			</div>
			<div class="row">
		</c:if>
	  <div class="col-sm-6">
		<a href="/user/items/${ci.getCategoryID()}" class="btn btn-default">
			<div class="card w-75">
			    <img class="card-img-top w-85" src="<c:url value="${ci.getCategoryImage()}"/>" alt="Card image">
		      <div class="card-body">
		        <h6 class="card-title">${ci.getCategoryName()}</h6>
		        <p class="card-text blockquote-footer">Manager Name: ${ci.getManagerName()}</p>
		      </div>
			</div>
		</a>
		</div>
		</c:forEach>
	</div>
</t:ordertemplate>
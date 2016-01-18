<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="member.register" /></title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div id="wrapper">
	<div id="menu">
		<jsp:include page="/include/menu.jsp" />
	</div>
	<div id="content">
		<h2><spring:message code="term" /></h2>
		<p><spring:message code="member.register" /></p>
		
		<form action="step2" method="post">
		<label for="agree">
			<input type="checkbox" name="agree" id="agree" value="true" />
			<spring:message code="term.agree" /></label>
			<input type="submit" value="<spring:message code='next.btn' />" />
		</form>
	</div>
</div>
</body>
</html>
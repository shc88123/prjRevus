<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="change.pwd.title" /></title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div id="wrapper">
	<div id="menu">
		<jsp:include page="/include/menu.jsp" />
	</div>
	<div id="content">
		<form:form commandName="authCmd">
			<p>
				<label><spring:message code="currentPw" />:<br>
				<form:password path="currentPw" />
				<form:errors path="currentPw" />
				</label>
			</p>
			<p>
				<label><spring:message code="newPw" />:<br>
				<form:password path="newPw" />
				<form:errors path="newPw" />
				</label>
			</p>
			<input type="submit" value="<spring:message code="change.btn" />" />
		</form:form>
	</div>
</div>
</body>
</html>
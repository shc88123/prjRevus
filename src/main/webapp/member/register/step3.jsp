<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<%-- <p><strong>${rr.name}님 </strong>회원가입을 완료하였습니다.</p> --%>
		<p><spring:message code="register.done" arguments="${rr.name}" /></p>
		<p><a href="<c:url value='/' />">[<spring:message code="go.main" />]</a></p>
	</div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
		<h2><spring:message code="member.info" /></h2>
		<%-- <form action="step3" method="post">
			<p>
				<label for="email">이메일:<br>
				<input type="text" name="email" id="email" value="${rr.email}">
				</label>
			</p>
			<p>
				<label for="name">이름:<br>
				<input type="text" name="name" id="name" value="${rr.name}">
				</label>
			</p>
			<p>
				<label for="password">비밀번호:<br>
				<input type="password" name="password" id="password">
				</label>
			</p>
			<p>
				<label for="confirmPassword">비밀번호 확인:<br>
				<input type="password" name="confirmPassword" id="confirmPassword">
				</label>
			</p>
			<input type="submit" value="가입 완료">
		</form> --%>
		<form:form action="step3" commandName="rr">
			<p>
				<label for="email"><spring:message code="email" />:<br>
				<form:input path="email" />
				<form:errors path="email" />
				</label>
			</p>
			<p>
				<label for="name"><spring:message code="name" />:<br>
				<form:input path="name" />
				<form:errors path="name" />
				</label>
			</p>
			<p>
				<label for="password"><spring:message code="password" />:<br>
				<form:password path="password" />
				<form:errors path="password" />
				</label>
			</p>
			<p>
				<label for="confirmPassword"><spring:message code="password.confirm" />:<br>
				<form:password path="confirmPassword" />
				<form:errors path="confirmPassword" />
				</label>
			</p>
			<input type="submit" value="<spring:message code="register.btn" />">
		</form:form>
	</div>
</div>
</body>
</html>
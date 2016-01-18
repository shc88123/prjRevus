<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HaeSeo</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div id="wrapper">
	<div id="menu">
		<jsp:include page="/include/menu.jsp" />
	</div>
	<div id="content">
	<h2>설문조사</h2>
		<form method="post">
			<!-- ModelAttribute ~ questions -->
			<c:forEach var="q" items="${questions}" varStatus="status">
			<p>
				<span>${status.index+1}. ${q.title}</span><br>
				<c:if test="${q.choice}">
					<c:forEach var="option" items="${q.options}">
						<label><input type="radio" name="responses[${status.index}]" 
									value="${option}" required />${option}</label>
					</c:forEach>
				</c:if>
				<c:if test="${!q.choice}">
					<input type="text" name="responses[${status.index}]" required />
				</c:if>
			</p>
			</c:forEach>
			<p>
				<span>당신의 선호 언어는?</span><br>
				<form:checkboxes name="favLanguage" items="${favLanguage}" path="favLanguage" />		
			</p>
			<!-- <p>
				<span>1. 당신의 역할은?</span><br>
				<label><input type="radio" name="responses[0]" value="서버" />서버 개발자</label>
				<label><input type="radio" name="responses[0]" value="프론트" />프론트 개발자</label>
				<label><input type="radio" name="responses[0]" value="풀스택" />풀스택 개발자</label>
			</p>
			<p>
				<span>2. 가장 많이 사용하는 개발도구는?</span><br>
				<label><input type="radio" name="responses[1]" value="Eclipse" />Eclipse</label>
				<label><input type="radio" name="responses[1]" value="Intellij" />Intellij</label>
				<label><input type="radio" name="responses[1]" value="Sublime" />Sublime</label>
			</p>
			<p>
				<span>3. 하고 싶은 말</span><br>
				<label><input type="text" name="responses[2]" /></label>		
			</p> -->
			<p>
				<span>응답자 위치:</span><br>
				<label><input type="text" name="res.location" required /></label>		
			</p>
			<p>
				<span>응답자 나이:</span><br>
				<label><input type="number" name="res.age" required /></label>		
			</p>
			<input type="submit" value="전송">
		</form>
	</div>
</div>
</body>
</html>
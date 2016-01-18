<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
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
		<p>응답 내용</p>
		<ul>
			<c:forEach var="response" items="${ansData.responses}" varStatus="status">
				<li>${status.index + 1}번 문항: ${response} </li>
			</c:forEach>
		</ul>
		<span>당신의 선호 언어는?</span>
		<p><span>선호 언어: </span>${Arrays.toString(favLanguage)}</p>
		<p>응답자 위치: ${ansData.res.location}</p>
		<p>응답자 나이: ${ansData.res.age}</p>
		<%-- <p><a href="<c:url value='/' />">[로그인 페이지 가기]</a></p> --%>
		<p><button type="button" class="btnGeneral" onclick="javascript:location.replace('<%=request.getContextPath()%>/')">첫 화면으로</button></p>
	</div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" media="all" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"
	type="text/javascript"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"
	type="text/javascript"></script>
<script>
	$(function() {
		$("#from").datepicker(
				{
					dateFormat : 'yymmdd00',
					prevText : '이전 달',
					nextText : '다음 달',
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
							'8월', '9월', '10월', '11월', '12월' ],
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
					dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
					dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
					showMonthAfterYear : true,
					yearSuffix : '년'
				});
		$("#to").datepicker(
				{
					dateFormat : 'yymmdd23',
					prevText : '이전 달',
					nextText : '다음 달',
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
							'8월', '9월', '10월', '11월', '12월' ],
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
					dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
					dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
					showMonthAfterYear : true,
					yearSuffix : '년'
				});
	});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 조회</title>
</head>
<body>
	<div id="wrapper">
		<div id="menu">
			<jsp:include page="/include/menu.jsp" />
		</div>
		<div id="content">
			<form:form commandName="cmd">
				<p>
					<label>from: <form:input path="from" /></label>
					<form:errors path="from" />
					<label>to: <form:input path="to" /></label>
					<form:errors path="to" />
					<input type="submit" value="조회" />
				</p>
			</form:form>
			<table>
				<tr>
					<th>아이디</th>
					<th>이메일</th>
					<th>이름</th>
					<th>가입일</th>
				</tr>
				<c:if test="${!empty members}">
					<c:forEach var="mem" items="${members}">
						<tr>
							<td>${mem.id}</td>
							<td><a href="<c:url value='/member/detail/${mem.id}' />">${mem.email}</a></td>
							<td>${mem.name}</td>
							<td><fmt:formatDate value="${mem.registerDate}"
									pattern="yyyy-MM-dd" /></td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty members}">
					<tr>
						<td colspan="4">표시할 내용이 없습니다.</td>
					</tr>
				</c:if>
			</table>
		</div>
	</div>
</body>
</html>
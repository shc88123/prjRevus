<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="subMenu">
		<ul>
			<%-- <% 
				 Enumeration e1 = request.getParameterNames();
				out.println("[ParameterNames!]<br>");
				
				while (e1.hasMoreElements()) {
					out.print(e1.nextElement()+"<br>");
				}
				Enumeration e2 = request.getAttributeNames();		
					out.print("[requestAttributeNames!]<br>");
					
				while (e2.hasMoreElements()) {
					String s = e2.nextElement().toString();
					if (!s.substring(0,3).equals("jav") && !s.substring(0,3).equals("org"))
					out.print(s+"<br>");
				}
				Enumeration e3 = session.getAttributeNames();
				
					out.print("[sessionAttributeNames!]<br>");
				while (e3.hasMoreElements()) {
					String s = e3.nextElement().toString();
					if (!s.substring(0,3).equals("jav") && !s.substring(0,3).equals("org"))
					out.print(s+"<br>");
				} 
			%> --%>
			<li class="subMenuItem" onclick="location.replace('<c:url value='/main' />')">글쓰기</li>
			<li class="subMenuItem" onclick="location.replace('<c:url value='/main' />')">즐겨찾기</li>
			<li class="subMenuItem" onclick="location.replace('<c:url value='/main' />')">최근 본 게시물</li>
			<li class="subMenuItem" onclick="location.replace('<c:url value='/main' />')">인기 리뷰</li>
			<li class="subMenuItem" onclick="location.replace('<c:url value='/main' />')">좋은 정보</li>
			<li class="subMenuItem" onclick="location.replace('<c:url value='/main' />')">공지</li>
			
			<c:choose>
				<c:when test="${requestScope.menuCmd=='.sa'}">
					<li class="subMenuItem"
						onclick="location.replace('./SaleReg.sa')">판매 처리</li>
					<li class="subMenuItem"
						onclick="location.replace('./SaleSrch.sa')">판매 조회</li>
				</c:when>
				<c:when test="${requestScope.menuCmd=='.cu'}">
					<li class="subMenuItem"
						onclick="location.replace('./CustReg.cu')">고객 등록</li>
					<li class="subMenuItem"
						onclick="location.replace('./CustSrch.cu')">고객 조회</li>
				</c:when>
				<c:when test="${requestScope.menuCmd=='.pr'}">
					<li class="subMenuItem"
						onclick="location.replace('./ProdReg.pr')">상품 등록</li>
					<li class="subMenuItem"
						onclick="location.replace('./ProdSrch.pr')">상품 조회</li>
				</c:when>
				<c:when test="${requestScope.menuCmd=='.me'}">
					<li class="subMenuItem"
						onclick="location.replace('./MemReg.me')">사용자 등록</li>
					<li class="subMenuItem"
						onclick="location.replace('./MemSrch.me')">사용자 조회</li>
				</c:when>
				<c:when test="${requestScope.menuCmd=='.bo'}">
					<li class="subMenuItem"
						onclick="location.replace('./BoardList.bo')">정보 게시판</li>
					<li class="subMenuItem"
						onclick="location.replace('#')">공지 사항</li>
				</c:when>
				<c:otherwise>
					<%-- <li class="subMenuItem" onclick="location.replace('<c:url value='/main' />')">좋은 하루 되세요</li> --%>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</body>
</html>
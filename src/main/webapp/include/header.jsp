<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<% request.setCharacterEncoding("UTF-8"); %>
<c:if test="${requestScope.menuCmd=='.sa'}">
	<c:set var="saCheck" value=" style='color: white; font-size: 12pt;' " />
</c:if>
<c:if test="${requestScope.menuCmd=='.cu' }">
	<c:set var="cuCheck" value=" style='color: white; font-size: 12pt;' " />
</c:if>
<c:if test="${requestScope.menuCmd=='.pr' }">
	<c:set var="prCheck" value=" style='color: white; font-size: 12pt;' " />
</c:if>
<c:if test="${requestScope.menuCmd=='.me' }">
	<c:set var="meCheck" value=" style='color: white; font-size: 10.1pt;' " />
</c:if>
<c:if test="${requestScope.menuCmd=='.bo' }">
	<c:set var="boCheck" value=" style='color: white; font-size: 12pt;' " />
</c:if>
<c:if test="${requestScope.menuCmd=='.do' }">
	<c:set var="doCheck" value=" style='color: white; font-size: 12pt;' " />
</c:if>
<div id="header">
	<div id="headerSub">
		<div id="headerSubLogo">
			<a href="<c:url value='/main' />" ><span id="logo">안녕하세용</span></a><br>
		</div>
		<div id="headerSubMenu">
<c:if test="${empty authInfo && !empty loginCommand}">
	<form:form commandName="loginCommand">
		<div id="menuUser">
			<div>
				<label><span><spring:message code="email" /> </span>
				<form:input path="email" />
				</label>
				<label><span><spring:message code="password" /> </span>
				<form:password path="password" />
				</label>
				<input type="submit" value="<spring:message code="login.btn" />" />
			</div>
			<div>
				<label><spring:message code="rememberEmail" />
				<form:checkbox path="rememberEmail" />
				</label>
			</div>
			<div>
				<form:errors />
				<form:errors path="email" />
				<form:errors path="password" />
				<form:errors path="rememberEmail" />
			</div>
		</div>
	</form:form>
</c:if>
<c:if test="${!empty authInfo}">
	<div id="menuUser">
			<span>${authInfo.name}님 환영합니다.</span>
			<span><button type="button" onclick="javascript:location.replace('<%=request.getContextPath()%>/logout')">로그아웃</button></span>
			<%-- <a href="<c:url value='/logout' />" style="color: #fff;"><span>로그아웃</span></a> --%>
	</div>
	<div id='menubar'>
		<ul>
			<li><a href="<c:url value='/main' />" ${doCheck}><span>MAIN</span></a></li>
			<%-- <li><a href="./BoardList.bo" ${boCheck}><span>정보 공유</span></a></li>
			<li><a href="./MemReg.me" ${meCheck}><span>사용자 관리</span></a></li>
			<li><a href="./ProdReg.pr" ${prCheck}><span>상품 관리</span></a></li>
			<li><a href="./CustReg.cu" ${cuCheck}><span>고객 관리</span></a></li> --%>
			<li><a href="<c:url value='/edit/changeAuthInfo' />"><span>개인정보 변경</span></a></li>
			<li>
				<c:if test="${authInfo.email == 'admin' }" >
					<a href="<c:url value='/memberList' />">회원목록(관리자)</a>				
				</c:if>
			</li>
		</ul>
	</div>
</c:if>
		</div>
	</div>
</div>
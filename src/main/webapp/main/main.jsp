<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>NENG</title>
<!-- jQuery library (served from Google) -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<!-- bxSlider Javascript file -->
<script src="/js/jquery.bxslider.min.js"></script>
<!-- bxSlider CSS file -->
<link href="/lib/jquery.bxslider.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<script	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"	type="text/javascript"></script>
<script type="text/javascript">
	// bxSlider
	$(document).ready(function(){
	  $('.bxslider').bxSlider();
	});
	// 댓글 보기
	function doReplyView(boardNum) {
		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/main/doReplyView.jsp",
			data: {
					num : boardNum
					},
			success : function(msg) {
				$("#divReplyView\\["+boardNum+"\\]").html(msg);
				$("#divReplyShowOrHide\\["+boardNum+"\\]").html(
						"<button type='button' class='btnGeneral' onclick='doReplyHide("+boardNum+");'>댓글 숨기기</button>");
			}
		});
	}
	// 댓글 숨기기
	function doReplyHide(boardNum) {
		$("#divReplyView\\["+boardNum+"\\]").html("");
		$("#divReplyShowOrHide\\["+boardNum+"\\]").html(
				"<button type='button' class='btnGeneral' onclick='doReplyView("+boardNum+");'>댓글 보기</button>");
	}
	// 댓글 달기
	function doReplyDo(boardNum) {
		var userEmail = document.getElementById("userEmail").value;
		var userName = document.getElementById("userName").value;
		var content = document.getElementById("reply"+boardNum).value;
		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/main/doReplyDo.jsp",
			data: {
					num : boardNum,
					email : userEmail,
					name : userName,
					content : content
					},
			success : function(msg) {
				$("#reply"+boardNum).val("");
				$("#divReplyView\\["+boardNum+"\\]").html(msg);
				$("#divReplyShowOrHide\\["+boardNum+"\\]").html(
						"<button type='button' class='btnGeneral' onclick='doReplyHide("+boardNum+");'>댓글 숨기기</button>");
				}, 
			complete : function() { /* alert("댓글을 입력하였습니다"); */ }
		});
	}
	// 글 쓰기
	function doWrite() {
		var content = document.getElementById("content");
		var scope = document.getElementById("scope");
		var file = document.getElementById("file");

		if (content.value == null || content.value == "") {
			alert('내용을 입력하세요!');
			content.focus();
			return;
		} else {
			var formData = new FormData();
			formData.append("content", content.value);
			formData.append("scope", scope.value);
			formData.append("file", $("input[name=file]")[0].files[0]);			
			$.ajax({
				type : "POST",
				url : "./doWrite.jsp",
				data : formData,
				processData: false,
	        	contentType: false,
				/* data: {
						prodName : prodName.value,
						price : price.value,
						selCate : selCate.value,
						selAvail : selAvail.value,
						prodDesc : prodDesc.value,
						prodFile : prodFile.value,
						mime : mime.value
               		},
               	contentType : "multipart/form-data; charset=UTF-8", */
				success : successProdCheck,
				complete : completeProdCheck
			});
		}
	}
	function successProdCheck(msg) { $("#mainTbl").html(msg); }
	function completeProdCheck() { }
</script>

</head>
<body>
<div id="wrapper">
<div id="menu">
	<jsp:include page="/include/menu.jsp" />
</div>
<div id="content">
<!-- 로그인 이후 -->
<c:if test="${!empty authInfo}">
<!-- 글 쓰기 -->
<div id="addDiv">
<form id="postFrm" name="postFrm" action="${pageContext.request.contextPath}/addBoard" enctype="multipart/form-data" method="post">
	<div id="addTitle">
		<input type="file" id="file" name="file" />
		<select name="postOption" id="postOption">
			<option value="전체">전체</option>
			<option value="친구만">친구만</option>
			<option value="나만보기">나만보기</option>
		</select>
		<input type="submit" value="게시" name="submitBtn" />
	</div>
	<div id="addText">
		<textarea id="posting" name="posting" cols="77" rows="5" placeholder="어떤 생각을 하고 계신가요?" required></textarea> 
	</div>
</form>
</div>
<!-- CONTENT -->
<c:forEach var="bb" items="${beanBoard}" varStatus="status">
<form id="reply[${bb.bnum}]" action="${pageContext.request.contextPath}/boardReplyDo/${beanPaging.currentPage}/${bb.bnum}" method="post">
<div class="postedItems">
	<div class="postedItem1">
		<span>글번호: ${bb.bnum}</span><span style="float: right;">작성일: <fmt:formatDate value="${bb.wdate}" pattern="yyyy-MM-dd HH:mm:ss" /></span><br>
		<c:if test="${bb.fileName != null}">
			<img src="${pageContext.request.contextPath}/upload/${bb.fileName}" width="100" height="100"><br>
		</c:if>	
		<textarea name="post" cols="77" rows="5" readonly>${bb.posting}</textarea> 
	</div>
	<!-- HIDDEN (postedItem2) -->
	<input type="hidden" id="userEmail" value="${sessionScope.authInfo.email}">
	<input type="hidden" id="userName" value="${sessionScope.authInfo.name}">
	<div class="postedItem2">
		<input type="text" id="reply${bb.bnum}" placeholder="댓글을 남겨보세요!" />
		<button type="button" class="btnGeneral" onclick="doReplyDo(${bb.bnum});">댓글 달기</button><br>
		<%-- <button type="submit" form="reply[${bb.bnum}]" class="btnGeneral" >댓글 달기</button><br> --%>
		<%-- <button type="button" class="btnGeneral" onclick="javascript:location.replace('<c:url value='/boardReplyView/${beanPaging.currentPage}/${bb.bnum}' />')">댓글 보기!</button> --%>
	</div>
	<!-- 댓글 보기 -->
	<div class="postedItem3">
		<div id="divReplyShowOrHide[${bb.bnum}]"><button type="button" class="btnGeneral" onclick="doReplyView(${bb.bnum});">댓글 보기</button></div>
		<div id="divReplyView[${bb.bnum}]"></div>
	</div>
	<%-- <c:if test="${!empty replies && replies.get(0).re_ref == bb.bnum}">
		<c:forEach var="r" items="${replies}" varStatus="status">
			<div>
				<input type="text" value="${r.posting}" readonly />
			</div>
		</c:forEach>
	</c:if> --%>
</div>
</form>
</c:forEach>
<!-- PAGING -->
<div class="postedItem4">
<c:choose>
<c:when test="${empty beanPaging}">
	<c:redirect url="/boardPage/1" />
</c:when>
<c:when test="${!empty beanPaging}">
	<c:if test="${beanPaging.startPage != 1}">
		<c:if test="${1 != beanPaging.startPage-1}">
			<a class='btnRound' href="${pageContext.request.contextPath}/boardPage/1">◀◀</a>
		</c:if>
		<a class='btnRound' href="${pageContext.request.contextPath}/boardPage/${beanPaging.startPage-1}">◀</a>
	</c:if>
	<c:forEach var="p" begin="${beanPaging.startPage}" end="${beanPaging.endPage}" step="1">
		<a class='btnRound' href="${pageContext.request.contextPath}/boardPage/${p}">${p}</a>
	</c:forEach>
	<c:if test="${beanPaging.endPage != beanPaging.lastPage}">
		<a class='btnRound' href="${pageContext.request.contextPath}/boardPage/${beanPaging.endPage + 1}">▶</a>
		<c:if test="${beanPaging.endPage + 1 != beanPaging.lastPage}">
			<a class='btnRound' href="${pageContext.request.contextPath}/boardPage/${beanPaging.lastPage}">▶▶</a>
		</c:if>
	</c:if>
</c:when>
<c:otherwise></c:otherwise>			
</c:choose>
</div>
</c:if>
</div>
</div>
</body>
</html>
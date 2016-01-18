<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="login.title" /></title>
<!-- common CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/style.css">
<!-- jQuery -->
<script src="//code.jquery.com/jquery-1.8.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- bxSlider -->
<script src="resources_bxslider/plugins/jquery.easing.1.3.js"></script>
<script src="resources_bxslider/jquery.bxslider.min.js"></script>
<link href="resources_bxslider/jquery.bxslider.css" rel="stylesheet" />
<!-- ckEditor -->
<script src="//cdn.ckeditor.com/4.5.6/full/ckeditor.js"></script>
<!-- <script src="resources_ckeditor/ckeditor.js"></script> -->
<script>
	// bxslider
	$(document).ready(function(){
		$('.bxslider').bxSlider({
			easing: 'easeOutElastic',
			speed: 2500,
			responsive: false,
			slideWidth: 800,
			mode: 'fade',
			slideMargin: 15,
			auto: true,
			autoControls: true
		});
	});
	// 공유
	kipid.popUpTwitter=function(){
	window.open("https://twitter.com/intent/tweet"
			+"?via=kipacti"
			+"&text="+encodeURIComponent( $("title").text() ) // Title in this html document
			+"&url="+encodeURIComponent(window.location.href)
		// , "_blank"
		// , 'width=600,height=400,resizable=yes,scrollbars=yes'
	);
};
</script>
</head>
<body>
<div id="wrapper">
	<div id="menu">
		<jsp:include page="/include/menu.jsp" />
	</div>
	<div id="content">
		@@!
		<!-- Slider -->
		<div class="bx-wrapper">
			<ul class="bxslider">
			  <li><img src="http://res.heraldm.com/content/image/2015/01/23/20150123001057_0.jpg" /></li>
			  <li><img src="http://img2.ruliweb.daum.net/mypi/gup/a/14/10/o/9435070455.jpg" /></li>  
			  <li><img src="http://cfile10.uf.tistory.com/image/251DC73654E1D93F0C6C1F" /></li>
			  
			</ul>
		</div>
		<!-- Editor -->
		<form class="form-horizontal" role="form" id="editorForm" method="post" action="/">
			<div class="form-group">
				<div class="form-group">
					<div class="col-lg-12">
					    <textarea class="ckeditor" id="ckeditor" name="ckeditor"></textarea>
					</div>
				</div>
				<div class="form-group">
					<div class="col-lg-12" align="right">
					    <button type="submit" class="btn btn-default">미완</button>
					</div>
				</div>
			</div>
		</form>
		<button type="button" onclick="javascript:this.innerHTML=CKEDITOR.instances.ckeditor.getData()" >CLICK</button>
		
		
		<h1 onclick="changeText(this)">Click on this text!</h1>

		<script>
		function changeText(id) { 
		    id.innerHTML = CKEDITOR.instances.ckeditor.getData();
		}
		</script>
		
		<script>
			$(function(){
				CKEDITOR.replace('ckeditor', {
					filebrowserUploadUrl: '${pageContext.request.contextPath}/upload',
					width: '85%',
					height: '500px'
				});
		        CKEDITOR.on('dialogDefinition', function( ev ){
		            var dialogName = ev.data.name;
		            var dialogDefinition = ev.data.definition;
		            switch (dialogName) {
		                case 'image': //Image Properties dialog
		                    //dialogDefinition.removeContents('info');
		                    dialogDefinition.removeContents('Link');
		                    dialogDefinition.removeContents('advanced');
		                    break;
		            }
		        });
		         
		    });
		</script>		
		<p><button type="button" class="btnGeneral" onclick="javascript:location.replace('${pageContext.request.contextPath}/register/step1')">가입하기</button></p>
		<p><button type="button" class="btnGeneral" onclick="javascript:location.replace('${pageContext.request.contextPath}/survey')">설문조사</button></p>
		<p><button onclick="kipid.popUpTwitter()">Twitter로 보내기</button></p>
	</div>
</div>
<%-- <form:form commandName="loginCommand">
	<p>
		<label><spring:message code="email" />:<br>
		<form:input path="email" />
		<form:errors path="email" />
		<form:errors />
		</label>
	</p>
	<p>
		<label><spring:message code="password" />:<br>
		<form:password path="password" />
		<form:errors path="password" />
		</label>
	</p>
	<p>
		<label><spring:message code="rememberEmail" />
		<form:checkbox path="rememberEmail" />
		<form:errors path="rememberEmail" />
		</label>
	</p>
	<input type="submit" value="<spring:message code="login.btn" />" />
</form:form>
<a href="#" onclick="javascript:location.replace('register/step1')">회원 가입하기</a><br>
<a href="#" onclick="javascript:location.replace('survey')">설문 조사</a> --%>
</body>
</html>
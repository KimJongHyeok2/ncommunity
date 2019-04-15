<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NCommunity</title>
<jsp:include page="/resources/include/combine/combine.jsp"/>
<script type="text/javascript">
$(document).ready(function() {
	resizeAll();
});
$(window).resize(resizeAll);
function resizeAll() {
	allHeight = $("html").height();
	headerHeight = $(".header").height();
	footerHeight = $(".footer").height();
	$(".content").css("height", allHeight - headerHeight - 11 + "px");
	contentHeight = $(".content").height();
	rightHeight = $(".rightContent").height();
/* 	$(".container-fluid").css("height", contentHeight - footerHeight - 17 + "px"); */
/* 	$(".container-fluid").css("min-height", $(".container-fluid").height() + "px"); */
}
function pageMove(type) {
	if(type == "join") {
		location.href = "${pageContext.request.contextPath}/join";
	} else if(type == "login") {
		location.href = "${pageContext.request.contextPath}/login";
	} else if(type == "logout") {
		$("#logoutForm").submit();
	}
}
function dropdown(type) {
	if(type == "free") {
		var x = document.getElementById("free-drop");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
			x.previousElementSibling.className += " w3-green";
		} else {
		   	x.className = x.className.replace(" w3-show", "");
		    x.previousElementSibling.className = 
		    x.previousElementSibling.className.replace(" w3-green", "");
		}	
	} else if(type == "video") {
		var x = document.getElementById("video-drop");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
			x.previousElementSibling.className += " w3-green";
		} else { 
			x.className = x.className.replace(" w3-show", "");
			x.previousElementSibling.className = 
			x.previousElementSibling.className.replace(" w3-green", "");
		}
	}
}
</script>
<style type="text/css">
.content {
	display: flex;
}
.content .leftMenu {
	width: 250px;
	margin-top: 1px;
}
.content .rightContent {
	flex-grow: 1;
	overflow: auto;
}
.footer {
	height: 150px;
	border: 1px solid;
}
@media (max-width:700px) {
	.content {
		flex-direction: row;
	}
	.content .leftMenu {
		display: none;
	}
}
</style>
</head>
<body>
<jsp:include page="/resources/include/header/header.jsp"/>
<div class="content">
	<div id="navtest" class="leftMenu">
		<div class="w3-sidebar w3-bar-block w3-card" style="width: 250px;">
		<div class="w3-bar-item w3-button w3-border-bottom w3-hover-blue" onclick="dropdown('free')">
		자유게시판 <i class="fa fa-caret-down"></i></div>
		<div id="free-drop" class="w3-hide w3-white w3-card-4">
			<a href="${pageContext.request.contextPath}/board?type=freeBoard" class="w3-bar-item w3-button w3-border-bottom w3-hover-blue">최신글</a>
			<a href="#" class="w3-bar-item w3-button w3-border-bottom w3-hover-blue">오늘의 인기글</a>
			<a href="#" class="w3-bar-item w3-button w3-border-bottom w3-hover-blue">주간 인기글</a>
		</div>
		<div class="w3-dropdown-click">
			<div class="w3-bar-item w3-button w3-border-bottom w3-hover-blue" onclick="dropdown('video')">
			동영상 게시판 <i class="fa fa-caret-down"></i>
			</div>
			<div id="video-drop" class="w3-dropdown-content w3-white w3-card-4">
				<a href="#" class="w3-bar-item w3-button w3-border-bottom w3-hover-blue">오늘의 인기글</a>
				<a href="#" class="w3-bar-item w3-button w3-border-bottom w3-hover-blue">주간 인기글</a>
			</div>
		</div>
		</div>
	</div>
	<div class="rightContent">
		<div class="container-fluid">
			<c:choose>				
				<c:when test="${param.type == 'freeBoard'}">
					<jsp:include page="board/list.jsp"/>
				</c:when>
				<c:when test="${param.type == 'freeWrite'}">
					<jsp:include page="board/write.jsp"/>
				</c:when>
			</c:choose>
		</div>
		<div class="footer">
			푸터
		</div>
	</div>
</div>
</body>
</html>
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
</script>
<style type="text/css">
.content {
	display: flex;
}
.content .leftMenu {
	width: 250px;
	border-right: 1px solid #D5D5D5;
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
	레프트
	</div>
	<div class="rightContent">
		<div class="container-fluid">
			<jsp:include page="board/free/write.jsp"/>
		</div>
		<div class="footer">
			푸터
		</div>
	</div>
</div>
</body>
</html>
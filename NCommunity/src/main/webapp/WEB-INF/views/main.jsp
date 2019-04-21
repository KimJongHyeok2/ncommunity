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
	if(getClientInfo().name == "Safari" || "Firefox" || "IE") {
		if(getClientInfo().name == "Safari") {		
			$(".browser").html("<strong>안내</strong> Safari 브라우저를 이용하고 계십니다. 해당 브라우저는 일부 기능이 정상적으로 호환되지 않으므로 Edge 또는 Chrome 브라우저를 이용해주세요.");
			$(".browser").addClass("on");
		} else if(getClientInfo().name == "Firefox") {
			$(".browser").html("<strong>안내</strong> Firefox 브라우저를 이용하고 계십니다. 해당 브라우저는 일부 기능이 정상적으로 호환되지 않으므로 Edge 또는 Chrome 브라우저를 이용해주세요.");
			$(".browser").addClass("on");
		} else if(getClientInfo().name == "IE") {
			$(".browser").html("<strong>안내</strong> Internet Explorer 브라우저를 이용하고 계십니다. 해당 브라우저는 일부 기능이 정상적으로 호환되지 않으므로 Edge 또는 Chrome 브라우저를 이용해주세요.");
			$(".browser").addClass("on");
		}
	}
});
$(window).resize(resizeAll);
function getClientInfo() {
    var userAgent = navigator.userAgent;
    var reg = null;
    var browser = {
        name: null,
        version: null
    };

    userAgent = userAgent.toLowerCase();

    if (userAgent.indexOf("opr") !== -1) {
        reg = /opr\/(\S+)/;
        browser.name = "Opera";
        browser.version = reg.exec(userAgent)[1];
    } else if (userAgent.indexOf("edge") !== -1) {
        reg = /edge\/(\S+)/;
        browser.name = "Edge";
        browser.version = reg.exec(userAgent)[1];
    } else if (userAgent.indexOf("chrome") !== -1) {
        reg = /chrome\/(\S+)/;
        browser.name = "Chrome";
        browser.version = reg.exec(userAgent)[1];
    } else if (userAgent.indexOf("safari") !== -1) {
        reg = /safari\/(\S+)/;
        browser.name = "Safari";
        browser.version = reg.exec(userAgent)[1];
    } else if (userAgent.indexOf("firefox") !== -1) {
        reg = /firefox\/(\S+)/;
        browser.name = "Firefox";
        browser.version = reg.exec(userAgent)[1];
    } else if (userAgent.indexOf("trident") !== -1) {
        browser.name = "IE";
        
        if (userAgent.indexOf("msie") !== -1) {
            reg = /msie (\S+)/;
            browser.version = reg.exec(userAgent)[1];
            browser.version = browser.version.replace(";", "");
        } else {
            reg = /rv:(\S+)/;
            browser.version = reg.exec(userAgent)[1];
        }
    }

    return browser;
}
function resizeAll() {
 	var windowWidth = $("html").width();
 	if(windowWidth >= 700) {
		$("#sidebar").css("display", "block");
	} else {
		$("#sidebar").css("display", "none");		
	}
	
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
	display: block;
	position: static;
	min-width: 250px;
	z-index: 2;
}
.content .leftMenu div {
	z-index: 2;
}
.content .rightContent {
	flex-grow: 1;
	overflow: auto;
}
.footer {
	padding: 10px 0;
	font-size: 10pt;
	color: gray;
	text-align: center;
	border-top: 1px solid #D5D5D5;
	border-bottom: 1px solid #D5D5D5;
	background-color: rgba(246, 246, 246, 0.4);
}
.footer div span {
	color: black;
}
.browser {
	display: none;
	position: fixed;
	bottom: 0;
	left: 0;
	z-index: 5;
	margin-left: 15px;
	margin-right: 15px;
}
.browser.on {
	display: block;
}
@media (max-width:700px) {
	.content {
		flex-direction: row;
	}
	.content .leftMenu {
		display: none;
		position: absolute;
	}
}
</style>
<script async charset="utf-8" src="//cdn.embedly.com/widgets/platform.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/animate.css"/>
</head>
<body>
<jsp:include page="/resources/include/header/header.jsp"/>
<div class="content">
	<div id="sidebar" class="leftMenu">
		<div class="w3-sidebar w3-bar-block w3-animate-left" style="min-width: 250px; border-right: 1px solid #D5D5D5;">
			<div class="w3-bar-item w3-button w3-hover-blue ${param.type == 'freeBoard-New' || param.type == 'freeBoard-Today' || param.type == 'freeBoard-Week' || param.type == 'freeWrite' || param.type == 'freeView' || param.type == 'freeUpdate'? 'w3-green':''}" onclick="dropdown('free')">
			자유게시판 <i class="fa fa-caret-down"></i></div>
			<div id="free-drop" class="w3-hide w3-white w3-card-4 ${param.type == 'freeBoard-New' || param.type == 'freeBoard-Today' || param.type == 'freeBoard-Week' || param.type == 'freeWrite' || param.type == 'freeView' || param.type == 'freeUpdate'? 'w3-show':''}">
				<a href="${pageContext.request.contextPath}/board?type=freeBoard-New&currPage=1" class="w3-bar-item w3-button w3-hover-blue">최신글</a>
				<a href="${pageContext.request.contextPath}/board?type=freeBoard-Today" class="w3-bar-item w3-button w3-hover-blue">오늘의 인기글</a>
				<a href="${pageContext.request.contextPath}/board?type=freeBoard-Week" class="w3-bar-item w3-button w3-hover-blue">주간 인기글</a>
			</div>
			<div class="w3-dropdown-click">
				<div class="w3-bar-item w3-buttonw3-hover-blue ${param.type == 'videoBoard-New' || param.type == 'videoWrite' || param.type == 'videoUpdate' || param.type == 'videoView'? 'w3-green':''}" onclick="dropdown('video')">
				동영상 게시판 <i class="fa fa-caret-down"></i>
				</div>
				<div id="video-drop" class="w3-dropdown-content w3-white w3-card-4 ${param.type == 'videoBoard-New' || param.type == 'videoWrite' || param.type == 'videoUpdate' || param.type == 'videoView'? 'w3-show':''}">
					<a href="${pageContext.request.contextPath}/board?type=videoBoard-New" class="w3-bar-item w3-button w3-hover-blue">최신 동영상</a>
					<a href="#" class="w3-bar-item w3-button w3-hover-blue">오늘의 인기 동영상</a>
					<a href="#" class="w3-bar-item w3-button w3-hover-blue">주간 인기 동영상</a>
				</div>
			</div>
		</div>
	</div>
	<div class="rightContent">
		<div class="container-fluid">
			<c:choose>				
				<c:when test="${param.type == 'freeBoard-New' || param.type == 'freeBoard-Today' || param.type == 'freeBoard-Week'}">
					<jsp:include page="board/list.jsp"/>
				</c:when>
				<c:when test="${param.type == 'freeWrite' || param.type == 'videoWrite'}">
					<jsp:include page="board/write.jsp"/>
				</c:when>
				<c:when test="${param.type == 'freeView'}">
					<jsp:include page="board/view.jsp"/>
				</c:when>
				<c:when test="${param.type == 'freeUpdate'}">
					<jsp:include page="board/update.jsp"/>
				</c:when>
				<c:when test="${param.type == 'videoBoard-New'}">
					<jsp:include page="board/videoList.jsp"/>
				</c:when>
				<c:when test="${param.type == 'videoView'}">
					<jsp:include page="board/videoView.jsp"/>
				</c:when>
				<c:otherwise>
					메인화면 준비 중입니다.
				</c:otherwise>
			</c:choose>
		</div>
		<div class="footer">
			<div>Copyright <span>KimJongHyeok.</span> All Rights Reserved.</div>
		</div>
	</div>
</div>
<div class="modal fade" id="myModal">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
		<!-- Modal Header -->
		<div class="modal-header">
		<h4 class="modal-title">안내</h4>
			<button type="button" class="close" data-dismiss="modal">×</button>
		</div>
		<!-- Modal body -->
		<div class="modal-body">
		</div>
		<!-- Modal footer -->
		<div class="modal-footer">
			<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		</div>
		</div>
	</div>
</div>
<div class="alert alert-danger browser">
</div>
</body>
</html>
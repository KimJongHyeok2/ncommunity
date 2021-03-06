<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
			x.previousElementSibling.className += " bg-primary text-white";
		} else {
		   	x.className = x.className.replace(" w3-show", "");
		    x.previousElementSibling.className = 
		    x.previousElementSibling.className.replace(" bg-primary text-white", "");
		}	
	} else if(type == "video") {
		var x = document.getElementById("video-drop");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
			x.previousElementSibling.className += " w3-red";
		} else { 
			x.className = x.className.replace(" w3-show", "");
			x.previousElementSibling.className = 
			x.previousElementSibling.className.replace(" w3-red", "");
		}
	}
}
function freeBoardView(obj) {
	location.href = "${pageContext.request.contextPath}/board/view?type=freeView&num=" + obj.value;
}
function videoBoardView(num) {
	location.href = "${pageContext.request.contextPath}/board/view?type=videoView&num=" + num;
}
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main2.css"/>
<script async charset="utf-8" src="//cdn.embedly.com/widgets/platform.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/animate.css"/>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"/>
</head>
<body>
<jsp:include page="/resources/include/header/header.jsp"/>
<div class="content">
	<div id="sidebar" class="leftMenu">
		<div class="w3-sidebar w3-bar-block w3-animate-left" style="min-width: 250px; border-right: 1px solid #D5D5D5;">
			<div id="free-menu" class="w3-bar-item w3-button w3-hover-teal ${param.type == 'freeBoard-New' || param.type == 'freeBoard-Today' || param.type == 'freeBoard-Week' || param.type == 'freeWrite' || param.type == 'freeView' || param.type == 'freeUpdate'? 'bg-primary text-white':''}" onclick="dropdown('free')">
			<i class="fas fa-pen"></i> 자유게시판 <i class="fa fa-caret-down"></i></div>
			<div id="free-drop" class="w3-hide w3-white w3-card-4 ${param.type == 'freeBoard-New' || param.type == 'freeBoard-Today' || param.type == 'freeBoard-Week' || param.type == 'freeWrite' || param.type == 'freeView' || param.type == 'freeUpdate'? 'w3-show':''}">
				<a href="${pageContext.request.contextPath}/board?type=freeBoard-New&currPage=1" class="w3-bar-item w3-button w3-hover-blue-gray">최신글</a>
				<a href="${pageContext.request.contextPath}/board?type=freeBoard-Today" class="w3-bar-item w3-button w3-hover-blue-gray">오늘의 인기글</a>
				<a href="${pageContext.request.contextPath}/board?type=freeBoard-Week" class="w3-bar-item w3-button w3-hover-blue-gray">주간 인기글</a>
			</div>
			<div class="w3-dropdown-click">
				<div class="w3-bar-item w3-button w3-hover-teal ${param.type == 'videoBoard-New' || param.type== 'videoBoard-Today' || param.type == 'videoBoard-Week' || param.type == 'videoWrite' || param.type == 'videoUpdate' || param.type == 'videoView'? 'w3-red':''}" onclick="dropdown('video')">
				<i class="fab fa-youtube"></i> 동영상 게시판 <i class="fa fa-caret-down"></i>
				</div>
				<div id="video-drop" class="w3-dropdown-content w3-white w3-card-4 ${param.type == 'videoBoard-New' || param.type== 'videoBoard-Today' || param.type == 'videoBoard-Week' || param.type == 'videoWrite' || param.type == 'videoUpdate' || param.type == 'videoView'? 'w3-show':''}">
					<a href="${pageContext.request.contextPath}/board?type=videoBoard-New" class="w3-bar-item w3-button w3-hover-blue-gray">최신 동영상</a>
					<a href="${pageContext.request.contextPath}/board?type=videoBoard-Today" class="w3-bar-item w3-button w3-hover-blue-gray">오늘의 인기 동영상</a>
					<a href="${pageContext.request.contextPath}/board?type=videoBoard-Week" class="w3-bar-item w3-button w3-hover-blue-gray">주간 인기 동영상</a>
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
				<c:when test="${param.type == 'videoBoard-New' || param.type == 'videoBoard-Today' || param.type == 'videoBoard-Week'}">
					<jsp:include page="board/videoList.jsp"/>
				</c:when>
				<c:when test="${param.type == 'videoView'}">
					<jsp:include page="board/videoView.jsp"/>
				</c:when>
				<c:when test="${param.type == 'videoUpdate'}">
					<jsp:include page="board/videoUpdate.jsp"/>
				</c:when>
				<c:when test="${param.type == 'memberInfoModify'}">					
					<jsp:include page="member/modify.jsp"/>
				</c:when>
				<c:otherwise>
					<div class="row margin">
						<div class="col-sm-6">
							<h3>자유게시판 최신글</h3>
							<ul class="list-group list-type">
							<c:choose>
									<c:when test="${not empty board_new && fn:length(board_new) != 0}">
										<c:forEach var="i" items="${board_new}">
											  <li class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" value="${i.num}" onclick="freeBoardView(this);">
											  	<div class="board-subject"><span class="text-info">${i.nickname}</span> ${i.subject}</div>
											    <span class="badge badge-primary badge-pill">${i.commentsCount}</span>
											  </li>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<li class="empty-list-main">
											작성된 글이 없습니다.
										</li>
									</c:otherwise>
							</c:choose>
							</ul>
						</div>
						<div class="col-sm-6">
							<h3>자유게시판 인기글</h3>
							<ul class="list-group list-type">
							<c:choose>
									<c:when test="${not empty board_today && fn:length(board_today) != 0}">
										<c:forEach var="i" items="${board_today}">
											  <li class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" value="${i.num}" onclick="freeBoardView(this);">
											  	<div class="board-subject"><span class="text-info">${i.nickname}</span> <span class="badge badge-danger">${i.rnum}</span> ${i.subject}</div>
											    <span class="badge badge-primary badge-pill">${i.commentsCount}</span>
											  </li>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<li class="empty-list-main">
											작성된 글이 없습니다.
										</li>
									</c:otherwise>
							</c:choose>
							</ul>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							<h3>오늘의 인기 동영상</h3>
						</div>
					</div>
					<div class="row margin">
						<c:choose>
							<c:when test="${not empty board_video_today && fn:length(board_video_today) != 0}">
								<c:forEach var="i" varStatus="index" items="${board_video_today}">
									<c:if test="${!index.last}">
										<div class="col-sm-6 col-md-6 col-lg-6 col-xl-3 video-card">
											<div class="card" onclick="videoBoardView(${i.num});">
												<img class="card-img-top" src="https://img.youtube.com/vi/${i.thumb}/mqdefault.jpg" alt="Card image">
												<div class="card-body board-subject">${i.subject}</div>
												<div><span class="badge badge-danger">${i.rnum}</span> <span class="text-info">${i.nickname}</span></div>
											</div>
										</div>
									</c:if>
									<c:if test="${index.last}">
										<div class="col-sm-6 col-md-6 col-lg-6 col-xl-3">
											<div class="card" onclick="videoBoardView(${i.num});">
												<img class="card-img-top" src="https://img.youtube.com/vi/${i.thumb}/mqdefault.jpg" alt="Card image">
												<div class="card-body board-subject">${i.subject}</div>
												<div><span class="badge badge-danger">${i.rnum}</span> <span class="text-info">${i.nickname}</span></div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</c:when>
							<c:otherwise>
							<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12">
								<div class="empty-list-main">
									등록된 동영상이 없습니다.
								</div>
							</div>
							</c:otherwise>
						</c:choose>
					</div>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(document).ready(function() {
	for(var i=0; i<${fn:length(dto)}; i++) {
		var today = new Date();
		var tYear = today.getFullYear();
		var tMonth = today.getMonth()+1;
		tMonth = (tMonth + "").length==1? ("0" + tMonth):tMonth;
		var tDate = today.getDate();
		tDate = (tDate.length + "")==1? ("0" + tDate):tDate;
		
		var regdate = new Date($("#regdate" + (i+1)).html().replace(/-/g, "/").replace(".0", ""));
		var rYear = regdate.getFullYear();
		var rMonth = regdate.getMonth()+1;
		rMonth = (rMonth + "").length==1? ("0" + rMonth):rMonth;
		var rDate = regdate.getDate();
		rDate = (rDate.length + "")==1? ("0" + rDate):rDate;
		
		if((tYear + "-" + tMonth + "-" + tDate) == (rYear + "-" + rMonth + "-" + rDate)) {
			$("#badge-new" + (i+1)).removeClass("off");
			var hour = regdate.getHours();
			hour = (hour + "").length==1? ("0" + hour):hour;
			var minute = regdate.getMinutes();
			minute = (minute + "").length==1? ("0" + minute):minute;			
			$("#regdate" + (i+1)).html(hour + ":" + minute);
		} else {
			$("#regdate" + (i+1)).html(rMonth + "-" + rDate);
		}
	}
});
function videoView(obj) {
	location.href = "${pageContext.request.contextPath}/board/view?type=videoView&num=" + obj.value;
}
function page(select) {
	var currPage = ${empty param.currPage? 0:param.currPage}; 
	
	if(currPage == 0) {
		currPage = 1;
	}
	
	if(select == "next") {
		if(currPage == ${empty pad.pageCount? 1:pad.pageCount} || ${fn:length(dto) == 0}) {
			$("#myModal .modal-body").html("마지막 페이지입니다.");
			$("#myModal").modal();
			return false;
		}
		currPage += 1;
		location.href = "${pageContext.request.contextPath}/board?type=videoBoard-New&currPage=" + currPage;
	} else if(select == "prev") {
		if(currPage == 1) {
			$("#myModal .modal-body").html("첫번째 페이지입니다.");
			$("#myModal").modal();
			return false;
		} else {
			currPage -= 1;
			location.href = "${pageContext.request.contextPath}/board?type=videoBoard-New&currPage=" + currPage;
		}
	}
}
</script>
<style>
.profile {
	width: 25px;
	height: 25px;
	border: 1px solid #D5D5D5;
	border-radius: 50px;
}
.margin {
	list-style-type: none;
	margin: 0;
	margin-bottom: 15px;
	padding: 0;
}
.video-content-wrapper {
	display: flex;
}
.video-content-wrapper .thumbnail {
	position: relative;
	width: 250px;
}
.video-content-wrapper .badge-box {
	position: absolute;
	margin: 0;
	padding: 0;
}
.video-content-wrapper .badge-box span {
	vertical-align: top;
}
.video-content-wrapper .thumbnail .thumb {
	width: 100%;
}
.video-content-wrapper .info {
	margin-left: 5px;
	max-width: 800px;
	overflow: hidden;
}
.video-content-wrapper .info .title {
	font-size: 17pt;
	color: black;
}
.video-content-wrapper .info .data-block {
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
	font-size: 10pt;
	border-right: 1px solid #D5D5D5;
	margin-right: 3px;
	padding-right: 3px;
}
.video-content-wrapper .info .data-block.last {
	margin-right: 0;
	padding-right: 0;
	border-right: none;
}
.video-content-wrapper .info .description-text {
	white-space: normal;
	text-align: left;
	word-wrap: break-word;
	height: 1.0em;
	line-height: 2.0;
	display: -webkit-box;
	-webkit-line-clamp: 3;
	-webkit-box-orient: vertical;
}
.video-content-wrapper .info .description-text p {
	margin: 0;
}
.off {
	display: none;
}
.empty-list {
	text-align: center;
	padding: 30px;
	border: 1px solid #D5D5D5;
	border-radius: 5px;
}
.btn-write {
	margin-bottom: 15px;
}
.btn-write:after {
	content: "";
	display: block;
	clear: both;
}
.page-item {
	cursor: pointer;
}
@media (max-width:1000px) {
	.video-content-wrapper .info .title {
		white-space: nowrap;
		text-overflow: ellipsis;
		overflow: hidden;
	}
}
</style>
<div class="jumbotron" style="margin-top: 15px; padding: 10px;">
	<c:choose>
		<c:when test="${param.type == 'videoBoard-New'}">
			<h3>최신 동영상 <span class="badge badge-primary">${empty param.currPage? 1:param.currPage}</span></h3>
		</c:when>
		<c:when test="${param.type == 'videoBoard-Today'}">
			<h3>오늘의 인기 동영상</h3>
		</c:when>
		<c:when test="${param.type == 'videoBoard-Week'}">
			<h3>주간 인기 동영상</h3>
		</c:when>
	</c:choose>
</div>
<ul class="list-group margin">
	<c:choose>
		<c:when test="${not empty dto && fn:length(dto) != 0}">
			<c:forEach var="i" varStatus="index" items="${dto}">
			  <li class="list-group-item list-group-item-action" value="${i.num}" onclick="videoView(this);">
			  	<div class="video-content-wrapper">
			  		<div class="thumbnail">
			  			<div class="badge-box">
				  			<c:if test="${param.type == 'videoBoard-Today' || param.type == 'videoBoard-Week'}">
				  				<span class="badge badge-danger">${i.rnum}</span>
				  			</c:if>
				  			<span class="badge badge-primary off" id="badge-new${index.count}">NEW</span>
			  			</div>
			  			<img width="250px" src="https://img.youtube.com/vi/${i.thumb}/mqdefault.jpg"/>
			  		</div>
			  		<div class="info text-fluid">
			  			<div class="title">
			  				${i.subject}
			  			</div>
			  			<div class="metadata">
			  				<c:if test="${not empty i.profile}">
			  					<span class="data-block"><img class="profile" src="${pageContext.request.contextPath}/resources/profile/${i.profile}"/> ${i.nickname}(${i.id})</span><span class="data-block">조회수 ${i.viewcnt}회</span><span id="regdate${index.count}" class="data-block last">${i.regdate}</span>
			  				</c:if>
			  				<c:if test="${empty i.profile}">
			  					<span class="data-block">${i.nickname}(${i.id})</span><span class="data-block">조회수 ${i.viewcnt}회</span><span id="regdate${index.count}" class="data-block last">${i.regdate}</span>
			  				</c:if>
			  			</div>
			  			<div class="recommend">
			  				<span class="data-block">좋아요 ${i.like}</span><span class="data-block">싫어요 ${i.hate}</span><span class="data-block last">댓글 ${i.commentsCount}</span>
			  			</div>
			  			<div class="description-text">
			  				${i.description}
			  			</div>
			  		</div>
			  	</div>
			  </li>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<li class="empty-list">
				등록된 동영상이 없습니다.
			</li>
		</c:otherwise>
	</c:choose>
</ul>
<div class="btn-write">
	<c:if test="${param.type == 'videoBoard-New'}">
		<button type="button" class="btn btn-outline-primary float-right" onclick="location.href='board/write?type=videoWrite'">작성하기</button>
	</c:if>
</div>
<c:if test="${not empty pad}">
	<ul class="pagination justify-content-center">
    	<li class="page-item"><a class="page-link text-primary" onclick="page('prev');">이전</a></li>
    	<li class="page-item"><a class="page-link text-primary" onclick="page('next');">다음</a></li>
	</ul>
</c:if>
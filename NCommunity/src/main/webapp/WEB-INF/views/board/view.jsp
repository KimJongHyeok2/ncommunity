<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(document).ready(function() {
	var today = new Date();
	var tYear = today.getFullYear();
	var tMonth = today.getMonth()+1;
	tMonth = (tMonth + "").length==1? ("0" + tMonth):tMonth;
	var tDate = today.getDate();
	tDate = (tDate.length + "")==1? ("0" + tDate):tDate;
		
	var regdate = new Date($("#regdate").html().replace("-", "/").replace(".0", ""));
	var rYear = regdate.getFullYear();
	var rMonth = regdate.getMonth()+1;
	rMonth = (rMonth + "").length==1? ("0" + rMonth):rMonth;
	var rDate = regdate.getDate();
	rDate = (rDate.length + "")==1? ("0" + rDate):rDate;
		
	if((tYear + "-" + tMonth + "-" + tDate) == (rYear + "-" + rMonth + "-" + rDate)) {
		var hour = regdate.getHours();
		hour = (hour + "").length==1? ("0" + hour):hour;
		var minute = regdate.getMinutes();
		minute = (minute + "").length==1? ("0" + minute):minute;
		$("#regdate").html(hour + ":" + minute);
	} else {
		$("#regdate").html(rMonth + "-" + rDate);
	}
	$(".v-content img").addClass("img-fluid");
	
	if(${empty dto}) {
		$("#myModal .modal-body").html("삭제되었거나 존재하지 않는 글입니다.");
		$("#myModal .modal-footer").attr("onclick", "history.back();")
		$("#myModal").modal();
	}
});
</script>
<style>
.container-view {
	margin-top: 15px;
	border: 1px solid #D5D5D5;
	border-radius: 5px;
}
.container-view .view-subject {
	display: flex;
	padding: 10px;
	border-bottom: 1px solid #D5D5D5;
}
.container-view .view-subject .subject {
	flex-grow: 1;
}
.container-view .view-subject .other {
	display: flex;
	text-align: center;
}
.container-view .view-subject .other .username span {
	color: gray;
}
.container-view .view-subject .other .viewcnt {
	width: 50px;
}
.container-view .view-subject .other .regdate {
	width: 50px;
}
.container-view .view-content {
	padding: 10px;
}
.container-view .view-content .v-content {
	min-height: 500px;
}
.container-view .view-content .recommend {
	text-align: center;
}
.container-function {
	margin-top: 15px;
}
.container-function:after {
	content: "";
	display: block;
	clear: both;
}
.container-function .view-function {
	float: right;
}
.container-comment-input {
	margin-top: 15px;
	margin-bottom: 15px;
	padding: 10px;
	border: 1px solid #D5D5D5;
	border-radius: 5px;
}
.container-comment-input .margin {
	margin-top: 5px;
}
.container-comment-input:after {
	content: "";
	display: block;
	clear: both;
}
.container-comment-title {
	margin-bottom: 5px;
}
.container-comment-list {
	margin-bottom: 15px;
	border: 1px solid #D5D5D5;
	border-radius: 5px;
}
.container-comment-list .comment-list {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
}
.container-comment-list .comment-list .comment-subject {
	display: flex;
	padding: 10px;
	border-bottom: 1px solid #D5D5D5;
}
.container-comment-list .comment-list .comment-subject .subject {
	flex-grow: 1;
}
.container-comment-list .comment-list .comment-subject .regdate {
	width: 70px;
	text-align: center;
}
.container-comment-list .comment-list .comment-content {
	padding: 10px;
}
.container-comment-list .comment-list .comment-content .c-content {
	margin-bottom: 5px;
}
.container-comment-list .comment-list .comment-content .recommend button img {
	width: 16px;
	height: 16px;
}
.container-comment-list .recomment-list {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
}
.container-comment-list .recomment-list .recomment-content {
	display: flex;
	box-sizing: border-box;
	border-top: 1px solid #D5D5D5;
}
.container-comment-list .recomment-list .recomment-content .arrow {
	width: 45px;
	height: 40px;
	padding-left: 10px;
	margin-right: 10px;
}
.container-comment-list .recomment-list .recomment-content .arrow img {
	width: 100%;
	height: 100%;
}
.container-comment-list .recomment-list .recomment-content .rc-content {
	flex-grow: 1;
	border-left: 1px solid #D5D5D5;
}
.container-comment-list .recomment-list .recomment-content .rc-content .rc-subject {
	display: flex;
	padding: 10px;
	border-bottom: 1px solid #D5D5D5;
}
.container-comment-list .recomment-list .recomment-content .rc-content .rc-subject .subject {
	flex-grow: 1;
}
.container-comment-list .recomment-list .recomment-content .rc-content .rc-subject .regdate {
	width: 70px;
	text-align: center;
}
.container-comment-list .recomment-list .recomment-content .rc-content .rc-content-inner {
	padding: 10px;
}
.container-comment-list .recomment-list .recomment-content .rc-content .rc-content-inner .rc-content-inner-content {
	margin-bottom: 5px;
}
@media (max-width:700px) {
	.view-subject .subject {
		text-overflow: ellipsis;
		overflow: hidden;
		white-space: nowrap;
	}
	.container-function .view-function {
		float: none;
		text-align: center;
	}
}
</style>
<div class="container-view">
	<div class="view-subject">
		<div class="subject">
			${dto.subject}
		</div>
		<div class="other">
			<div class="username">${dto.nickname}(<span>${dto.id}</span>)</div>
			<div class="viewcnt"><span class="badge badge-pill badge-info">${dto.viewcnt}</span></div>
			<div class="regdate" id="regdate">${dto.regdate}</div>
		</div>
	</div>
	<div class="view-content">
		<div class="v-content">
			${dto.content}
		</div>
		<div class="recommend">
			<button type="button" class="btn btn-primary">
				좋아요 <span class="badge badge-light">${dto.like}</span>
			</button>
			<button type="button" class="btn btn-danger">
				싫어요 <span class="badge badge-light">${dto.hate}</span>
			</button>
		</div>
	</div>
</div>
<div class="container-function">
	<div class="view-function">
		<button type="button" class="btn btn-outline-primary">수정하기</button>
		<button type="button" class="btn btn-outline-danger">삭제하기</button>
		<button type="button" class="btn btn-outline-secondary">목록으로</button>
	</div>
</div>
<div class="container-comment-input">
  <textarea class="form-control" rows="5" id="comment"  placeholder="내용을 입력해주세요."></textarea>
  (<span id="comment-limit" class="margin">0</span>/300)<button type="button" class="btn btn-outline-primary float-right margin">작성하기</button>
</div>
<div class="container-comment-title">
	댓글 <span class="badge badge-pill badge-primary">0</span>
</div>
<div class="container-comment-list">
	<ul class="comment-list">
		<li>
			<div class="comment-subject">
				<div class="subject">
					작성자
				</div>
				<div class="regdate">
					01:55
				</div>
			</div>
			<div class="comment-content">
				<div class="c-content">
					내용
				</div>
			<div class="recommend">
				  <div class="btn-group">
				    <button type="button" class="btn btn-info">답글(0)</button>
				    <button type="button" class="btn btn-info dropdown-toggle dropdown-toggle-split" data-toggle="dropdown">
				      <span class="caret"></span>
				    </button>
				  </div>
				<button type="button" class="btn btn-primary">
					<span><img src="${pageContext.request.contextPath}/resources/img/board/like.png"/></span> <span class="badge badge-light">7</span>
				</button>
				<button type="button" class="btn btn-danger">
					<span><img src="${pageContext.request.contextPath}/resources/img/board/dislike.png"/></span> <span class="badge badge-light">7</span>
				</button>
				<div class="btn-group float-right">
					<button type="button" class="btn btn-outline-primary">수정</button>
					<button type="button" class="btn btn-outline-danger">삭제</button>
				</div>
			</div>
			</div>
		</li>
	</ul>
	<ul class="recomment-list">
		<li>
			<div class="recomment-content">
				<div class="arrow"><img src="${pageContext.request.contextPath}/resources/img/board/arrow.png"/></div>
				<div class="rc-content">
					<div class="rc-subject">
						<div class="subject">
							제목
						</div>
						<div class="regdate">
							02:00
						</div>
					</div>
					<div class="rc-content-inner">
						<div class="rc-content-inner-content">
							내용
						</div>
						<div class="btn-group">
							<button type="button" class="btn btn-outline-primary">수정</button>
							<button type="button" class="btn btn-outline-danger">삭제</button>
						</div>
					</div>
				</div>
			</div>
		</li>
	</ul>
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
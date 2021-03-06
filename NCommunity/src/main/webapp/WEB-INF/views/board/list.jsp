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
			$("#subject" + (i+1)).append(" <span class='badge badge-primary'>NEW</span>");
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
function view(num) {
	if(${param.type == "freeBoard-New" || param.type == "freeBoard-Today" || param.type == "freeBoard-Week"}) {
		location.href = "${pageContext.request.contextPath}/board/view?type=freeView&num=" + num;
	} else if(${param.type == "videoBoard"}) {
		location.href = "${pageContext.request.contextPath}/board/view?type=videoView&num=" + num;		
	}
}
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/list.css"/>
<div class="jumbotron" style="margin-top: 15px; padding: 10px;">
	<c:choose>
		<c:when test="${param.type == 'freeBoard-New'}">
			<h3>자유게시판 최신글</h3>
		</c:when>
		<c:when test="${param.type == 'freeBoard-Today'}">
			<h3>자유게시판 오늘의 인기글</h3>
		</c:when>
		<c:when test="${param.type == 'freeBoard-Week'}">
			<h3>자유게시판 주간 인기글</h3>
		</c:when>
	</c:choose>
</div>
<table class="table table-hover">
	<thead>
		<tr class="bg-primary">
			<td>구분</td><td class="subject">제목</td><td>작성자</td><td class="td-sm-1">조회수</td><td class="td-sm-1">일시</td>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(dto) != 0 && not empty dto}">
				<c:forEach var="i" varStatus="index" items="${dto}">			
					<tr>
						<td>
							<c:choose>
								<c:when test="${param.type == 'freeBoard-Today' || param.type == 'freeBoard-Week'}">
									<span class="badge badge-danger">${i.rnum}</span>
								</c:when>
								<c:otherwise>
									${i.num}
								</c:otherwise>
							</c:choose>
						</td>
						<td id="subject${index.count}" class="subject" onclick="view(${i.num});">${i.subject}<span class="text-primary">(${i.commentsCount})</span></td>
						<c:if test="${not empty i.profile}">
						<td><img class="profile" src="${pageContext.request.contextPath}/resources/profile/${i.profile}"/> ${i.nickname}</td>
						</c:if>
						<c:if test="${empty i.profile}">						
						<td>${i.nickname}</td>
						</c:if>
						<td class="td-sm-1">${i.viewcnt}</td>
						<td id="regdate${index.count}" class="td-sm-1">${i.regdate}</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="5" class="empty-list">작성된 글이 존재하지 않습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>
<div class="btn-write">
	<c:if test="${param.type == 'freeBoard-New'}">
		<button type="button" class="btn btn-outline-primary float-right" onclick="location.href='board/write?type=freeWrite'">작성하기</button>
	</c:if>
</div>
<ul class="pagination justify-content-center">
	<c:choose>
		<c:when test="${not empty pad}">
			<c:if test="${pad.startPage > pad.pageBlock}">
				<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/board?type=freeBoard-New&currPage=${pad.startPage - 10}">이전</a></li>				
			</c:if>
			<c:forEach var="i" varStatus="index" begin="${pad.startPage}" end="${pad.endPage}">
				<c:choose>
					<c:when test="${param.currPage == index.count}">
						<li class="page-item active"><a class="page-link">${index.count}</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/board?type=freeBoard-New&currPage=${index.count}">${index.count}</a></li>						
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pad.endPage < pad.pageCount}">
				<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/board?type=freeBoard-New&currPage=${pad.startPage + 10}">다음</a></li>
			</c:if>
		</c:when>
	</c:choose>
</ul>

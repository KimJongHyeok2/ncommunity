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
		
		var regdate = new Date($("#regdate" + (i+1)).html().replace("-", "/").replace(".0", ""));
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
		}
	}
});
</script>
<style>
.table {
	margin-top: 15px;
    border-collapse: separate !important;
    border-spacing: 0;
	border: 1px solid #D5D5D5;
	border-radius: 5px;
}
.table thead td {
	text-align: center;
	border-top: none;
}
.table tbody td:not(.test) {
	text-align: center;
}
.table .subject {
	max-width: 150px;
}
.btn-write:after {
	content: "";
	display: block;
	clear: both;
}
@media (max-width:500px) {
	.table tbody td {
		text-overflow: ellipsis;
		overflow: hidden;
		white-space: nowrap;
	}
}
</style>
<table class="table table-hover">
	<thead>
		<tr class="table-primary">
			<td>구분</td><td class="subject">제목</td><td>작성자</td><td>조회수</td><td>일시</td>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(dto) != 0 && not empty dto}">
				<c:forEach var="i" varStatus="index" items="${dto}">			
					<tr>
						<td>${i.num}</td><td id="subject${index.count}" class="subject">${i.subject}</td><td>${i.nickname}</td><td>${i.viewcnt}</td>
						<td id="regdate${index.count}">${i.regdate}</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="5">작성된 글이 존재하지 않습니다.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>
<div class="btn-write">
	<button type="button" class="btn btn-outline-primary float-right" onclick="location.href='board/write?type=freeWrite'">작성하기</button>
</div>
<ul class="pagination justify-content-center">
	<c:choose>
		<c:when test="${not empty pad}">
			<c:if test="${pad.startPage > pad.pageBlock}">
				<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/board?type=freeBoard&currPage=${pad.startPage - 10}">이전</a></li>				
			</c:if>
			<c:forEach var="i" varStatus="index" begin="${pad.startPage}" end="${pad.endPage}">
				<c:choose>
					<c:when test="${param.currPage == index.count}">
						<li class="page-item active"><a class="page-link">${index.count}</a></li>	
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/board?type=freeBoard&currPage=${index.count}">${index.count}</a></li>						
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pad.endPage < pad.pageCount}">
				<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/board?type=freeBoard&currPage=${pad.startPage + 10}">다음</a></li>
			</c:if>
		</c:when>
	</c:choose>
</ul>
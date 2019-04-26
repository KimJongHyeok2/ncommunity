<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<jsp:include page="/resources/include/combine/combine.jsp"/>
<script type="text/javascript">
$(document).ready(function() {
	if(${not empty param.result}) {
		if(${param.result=='fail'}) {
			$("#login-fail").addClass("on");
		} else if(${param.result=='blocked'}) {
			$("#myModal .modal-body").html("정지된 계정입니다.");
			$("#myModal").modal();
		}
	}
});
function loginValid(form) {
	$("#login-fail").removeClass("on");
	if(form["mem_id"].value == "" || form["mem_id"].value == null || form["mem_id"].value.length == 0) {
		$("#invalid-id").addClass("on");
		return false;
	} else {
		$("#invalid-id").removeClass("on");
	}
	if(form["mem_pw"].value == "" || form["mem_pw"].value == null || form["mem_pw"].value.length == 0) {
		$("#invalid-pw").addClass("on");
		return false;
	} else {
		$("#invalid-pw").removeClass("on");
	}
}
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/login.css"/>
</head>
<body>
<div class="loginWrapper">
	<div class="loginInner">
		<div class="logo">
			<div onclick="location.href='${pageContext.request.contextPath}/'"></div>
		</div>
		<div class="container-fluid form">
		<c:url value="/loginAuth" var="loginUrl"/>
			<form id="loginForm" action="${loginUrl}" method="post" onsubmit="return loginValid(this);">
				<div class="form-group">
					<input type="text" class="form-control" id="mem_id" placeholder="Enter userid" name="mem_id"/>
				<div id="invalid-id" class="invalid-feedback">아이디를 입력해주세요.</div>
				</div>
				<div class="form-group">
					<input type="password" class="form-control" id="mem_pw" placeholder="Enter password" name="mem_pw"/>
				<div id="invalid-pw" class="invalid-feedback">비밀번호를 입력해주세요.</div>
				<div id="login-fail" class="invalid-feedback">아이디 또는 비밀번호가 올바르지 않습니다.</div>
				</div>
				<div class="form-group">
					<button type="submit" class="btn btn-primary btn-lg btn-block">로그인</button>
				</div>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
			<hr>
			<div class="form-group">
				<!-- <span>아이디 찾기</span><span>비밀번호 찾기</span> --><span class="last"><a href="${pageContext.request.contextPath}/join">회원가입</a></span>
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
		</div>
		<jsp:include page="/resources/include/footer/footer.jsp"/>
	</div>
</div>
</body>
</html>
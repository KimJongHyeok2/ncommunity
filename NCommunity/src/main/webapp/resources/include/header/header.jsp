<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<script>
$(document).ready(function() {
	$("#left-open").click(function() {
		$("#sidebar").toggle();
	});
});
function pageMove(type) {
	if(type == "join") {
		location.href = "${pageContext.request.contextPath}/join";
	} else if(type == "login") {
		location.href = "${pageContext.request.contextPath}/login";
	} else if(type == "logout") {
		$("#logoutForm").submit();
	} else if(type == "memberCog") {
		location.href = "${pageContext.request.contextPath}/member/modify?type=memberInfoModify";
	}
}
</script>
<style>
.header {
	padding: 5px;
	border-bottom: 1px solid #D5D5D5;
}
.header:after {
	content: "";
	display: block;
	clear: both;
}
.header .logo {
	float: left;
	width: 300px;
	height: 57px;
	cursor: pointer;
}
.header .logo img {
	width: 100%;
	height: 100%;
}
.header .info {
	display: flex;
	align-items: center;
	float: right;
	height: 57px;
}
.header .info #left-open-div {
	display: none;
}
.header .info .dropdown .dropdown-menu {
	width: 100%;
}
.header .info .dropdown .dropdown-menu h5 {
	margin: 0;
}
@media (max-width:700px) {
	.header .logo {
		float: none;
		margin: auto;
		margin-bottom: 5px;
	}
	.header .info {
		float: none;
		display: flex;
		justify-content: center;
		width: auto;
		margin: auto;
	}
	.header .info #left-open {
		margin-right: 5px;
	}
	.header .info #left-open-div {
		display: block;
	}
}
</style>
<div class="header">
	<div class="logo" onclick="location.href='${pageContext.request.contextPath}'">
		<img class="img-fluid" src="${pageContext.request.contextPath}/resources/img/main/mainLogo2.png"/>
	</div>
	<div class="info">
		<div id="left-open-div" class="dropdown">
			<button id="left-open" type="button" class="btn btn-outline-secondary">&#9776;</button>
		</div>
		<s:authorize access="hasRole('ROLE_USER')">
			<c:url value="/logoutAuth" var="logout"/>
			<form id="logoutForm" action="${logout}" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
			<div class="dropdown dropleft">
 			  <button type="button" class="btn btn-outline-info dropdown-toggle" data-toggle="dropdown">
			    <i class="fas fa-user"></i>
			  </button>
			  <div class="dropdown-menu">
			   	<h5 class="dropdown-header">${sessionScope.nickname}(${sessionScope.id})</h5>
			    <a class="dropdown-item" onclick="pageMove('logout');"><i class="fas fa-sign-out-alt"></i> 로그아웃</a>
			    <a class="dropdown-item" onclick="pageMove('memberCog');"><i class="fas fa-user-cog"></i> 정보수정</a>
			  </div>
			</div>
		</s:authorize>
		<s:authorize access="!hasRole('ROLE_USER')">
			<div class="dropdown">
				<button type="button" class="btn btn-outline-primary" onclick="pageMove('login');">로그인</button>
				<button type="button" class="btn btn-outline-info" onclick="pageMove('join');">회원가입</button>
			</div>
		</s:authorize>
	</div>
</div>
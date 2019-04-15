<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<script>
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
}
.header .logo img {
	width: 100%;
	height: 100%;
}
.header .info {
	float: right;
	line-height: 55px;
}
.header .info .dropdown .dropdown-menu {
	width: 100%;
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
	.header .info button {
		margin-right: 5px;
	}
}
</style>
<div class="header">
	<div class="logo">
		<img class="img-fluid" src="${pageContext.request.contextPath}/resources/img/main/mainLogo2.png"/>
	</div>
	<div class="info">
		<s:authorize access="hasRole('ROLE_USER')">
			<c:url value="/logoutAuth" var="logout"/>
			<!-- <button type="button" class="btn btn-outline-danger" onclick="pageMove('logout');">로그아웃</button> -->
			<form id="logoutForm" action="${logout}" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
			<div class="dropdown">
			  <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">
			    ${sessionScope.nickname}(<s:authentication property="name"/>)님
			  </button>
			  <div class="dropdown-menu">
			    <a class="dropdown-item" onclick="pageMove('logout');">로그아웃</a>
<!-- 			<div class="dropdown-divider"></div>
			    <a class="dropdown-item" href="#">Another link</a> -->
			  </div>
			</div>
		</s:authorize>
		<s:authorize access="!hasRole('ROLE_USER')">
			<button type="button" class="btn btn-outline-primary" onclick="pageMove('login');">로그인</button>
			<button type="button" class="btn btn-outline-info" onclick="pageMove('join');">회원가입</button>
		</s:authorize>
	</div>
</div>
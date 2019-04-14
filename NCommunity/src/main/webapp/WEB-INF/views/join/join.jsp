<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/animate.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
var idFlag = false;
var pwFlag = false;
var pw2Flag = false;
var emailFlag = false;
var emailAccessFlag = false;

$(document).ready(function() {
	birthSet();
	$(document).on("click", ".dropdown-item", function() {
		$(this).parent("div").parent(".dropdown").find("button").html($(this).html());
		daySet();
	});
});

function checkID(id) {
	var pattern = /^([a-zA-Z\d]{6,10})$/;
	
	if(id == null) {
		$("#mem_id").parent(".form-group").find(".valid-feedback").removeClass("on");
		$(id).parent(".form-group").find(".invalid-feedback").html("영문 대소문자 및 숫자를 포함하여 6자 이상 10자 이하로 작성해주세요.");
		$("#mem_id").parent(".form-group").find(".invalid-feedback").addClass("on");
		return false;
	} else {
		if(new RegExp(pattern).test(id.value)) {
			var header = $("#header").val();
			var token = $("#token").val();
			
			$.ajax({
				url: "${pageContext.request.contextPath}/join/idOverlap",
				type: "POST",
				cache: false,
				beforeSend: function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				data: {
					"id" : id.value,
				},
				success: function(data, status) {
					if(status == "success") {
						if(data == "Ok") {
							$(id).parent(".form-group").find(".invalid-feedback").removeClass("on");
							$(id).parent(".form-group").find(".valid-feedback").addClass("on");
							idFlag = true;						
						} else if(data == "Fail") {
							$(id).parent(".form-group").find(".valid-feedback").removeClass("on");
							$(id).parent(".form-group").find(".invalid-feedback").html("이미 사용 중인 아이디입니다.");
							$(id).parent(".form-group").find(".invalid-feedback").addClass("on");
							idFlag = false;
						} else {
							$(id).parent(".form-group").find(".valid-feedback").removeClass("on");
							$(id).parent(".form-group").find(".invalid-feedback").html("알 수 없는 오류입니다.");
							$(id).parent(".form-group").find(".invalid-feedback").addClass("on");
							idFlag = false;
						}
					}
				}
			});
		} else {
			$(id).parent(".form-group").find(".valid-feedback").removeClass("on");
			$(id).parent(".form-group").find(".invalid-feedback").html("영문 대소문자 및 숫자를 포함하여 6자 이상 10자 이하로 작성해주세요.");
			$(id).parent(".form-group").find(".invalid-feedback").addClass("on");
			idFlag = false;
		}	
	}
}
function checkPW(pw) {
	var pattern = /^(?=.*\d)(?=.*\W)(?=.*[a-zA-Z]).{8,20}$/;
	
	if(pw == null) {
		$("#mem_pw").parent(".form-group").find(".valid-feedback").removeClass("on");
		$("#mem_pw").parent(".form-group").find(".invalid-feedback").addClass("on");
		return false;
	} else {
		if(new RegExp(pattern).test(pw.value)) {
			$(pw).parent(".form-group").find(".invalid-feedback").removeClass("on");
			$(pw).parent(".form-group").find(".valid-feedback").addClass("on");
			pwFlag = true;
		} else {
			$(pw).parent(".form-group").find(".valid-feedback").removeClass("on");
			$(pw).parent(".form-group").find(".invalid-feedback").addClass("on");
			pwFlag = false;
		}
	}

}
function checkPW2(pw) {
	var firstPW = $("#mem_pw").val();
	
	if(pw == null) {
		$("#mem_pw2").parent(".form-group").find(".valid-feedback").removeClass("on");
		$("#mem_pw2").parent(".form-group").find(".invalid-feedback").addClass("on");
		return false;
	} else {
		if(pw.value == null || pw.value == "" || pw.value.length == 0) {
			$(pw).parent(".form-group").find(".valid-feedback").removeClass("on");
			$(pw).parent(".form-group").find(".invalid-feedback").addClass("on");
			pw2Flag = false;
		} else {
			if(firstPW == pw.value) {
				$(pw).parent(".form-group").find(".invalid-feedback").removeClass("on");
				$(pw).parent(".form-group").find(".valid-feedback").addClass("on");
				pw2Flag = true;
			} else {
				$(pw).parent(".form-group").find(".valid-feedback").removeClass("on");
				$(pw).parent(".form-group").find(".invalid-feedback").addClass("on");
				pw2Flag = false;
			}		
		}
	}

}
function birthSet() {
	var nowDate = new Date();
	var Year = nowDate.getFullYear();
	$("#year-button").html(Year);
	var Month = eval(nowDate.getMonth())+1;
	$("#month-button").html(Month);
	var nowDay = eval(nowDate.getDate());
	$("#date-button").html(nowDay);
	var startYear = Year-70;
	
	var yearValue = "";
	var monthValue = "";
	
	for(var i=0; i<=70; i++) {
		yearValue += "<span class='dropdown-item'>" + (startYear + i) + "</span>";
	}
	for(var i=0; i<12; i++) {
		monthValue += "<span class='dropdown-item') >" + (i+1) + "</span>";
	}
	
	$("#year-dropdown").html(yearValue);
	$("#month-dropdown").html(monthValue);
	daySet();
}
function daySet() {
	var Year = $("#year-button").html().trim();
	var Month = $("#month-button").html().trim();
 	var Day = [31,28,31,30,31,30,31,31,30,31,30,31];
	
	if((Year % 4 == 0 && Year % 100 != 0) || Year % 400 == 0) {
		Day[1] = 29;	
	}
	
	var dayValue = "";
	for(var i=0; i<Day[Month-1]; i++) {
		dayValue += "<span id='day" + (i+1) + "' class='dropdown-item'>" + (i+1) + "</span>";
	}
	
	$("#date-dropdown").html(dayValue);
	
	var selectDay = $("#date-button").html();
	if(selectDay > Day[Month-1]) {
		$("#date-button").html($("#day" + (Day[Month-1])).html());
	} else {
		$("#date-button").html($("#day" + selectDay).html());		
	}
}
function checkEmail(email) {
	var pattern = /^(([a-zA-Z\d][-_]?){3,15})@([a-zA-z\d]{5,15})\.([a-z]{2,3})$/;
	
	if(email == null) {
		$("#mem_email").parent(".form-group").find(".valid-feedback").removeClass("on");
		$("#mem_email").parent(".form-group").find(".invalid-feedback").addClass("on");
		return false;
	} else {
		if(new RegExp(pattern).test(email.value)) {
			$(email).parent(".form-group").find(".invalid-feedback").removeClass("on");
			$(email).parent(".form-group").find(".valid-feedback").addClass("on");
			$("#email-access-group").removeClass("off");
			$("#email-access-group").addClass("animated bounce");
			emailFlag = true;
		} else {
			$(email).parent(".form-group").find(".valid-feedback").removeClass("on");
			$(email).parent(".form-group").find(".invalid-feedback").addClass("on");
			$("#email-access-group").removeClass("animated bounce");
			$("#email-access-group").addClass("off");
			emailFlag = false;
		}		
	}
}
function accessEmail(btn) {
 	$(btn).html("<span class='spinner-grow spinner-grow-sm'></span>");
 	
	var header = $("#header").val();
	var token = $("#token").val();
 	
	$.ajax({
		url: "${pageContext.request.contextPath}/join/sendEmail",
		type: "POST",
		cache: false,
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		data: {
			"email" : $("#mem_email").val()
		},
		success: function(data, status) {
			if(status == "success") {
				if(data != 0) {
					$(btn).attr("onclick", "accessEmailOk('" + data + "');");
				} else if(data == 0) {
					$("#myModal .modal-body").html("알 수 없는 오류입니다.");
					$("#myModal").modal();
				}
			}
		}
	});
}
function accessEmailOk(accessKey_num) {
	var access_key = $("#access_key").val();
	
	if(access_key == null || access_key == "" || access_key.length == 0) {
		$("#email-access-group").find(".invalid-feedback").addClass("on");
		return false;
	}
	
	var header = $("#header").val();
	var token = $("#token").val();
	
	$.ajax({
		url: "${pageContext.request.contextPath}/join/emailAccess",
		type: "POST",
		cache: false,
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		data: {
			"ekey_num" : accessKey_num,
			"ekey_accesskey" : access_key
		},
		success: function(data, status) {
			if(status == "success") {
				if(data == "Ok") {
					$("#access_btn").removeClass("btn-grow");
					$("#access_btn").addClass("btn-info");
					$("#access_btn").html("완료");
					$("#access_btn").removeAttr("onclick");
					$("#mem_email").attr("disabled", "disabled");
					$("#email-access-group").find(".invalid-feedback").removeClass("on");
					$("#email-access-group").find(".valid-feedback").addClass("on");
					emailAccessFlag = true;
				} else {
					$("#email-access-group").find(".valid-feedback").removeClass("on");
					$("#email-access-group").find(".invalid-feedback").addClass("on");
					emailAccessFlag = false;
				}
			}
		}
	});
}
function joinSubmit() {
	var id = document.getElementById("mem_id");
	var pw = document.getElementById("mem_pw");
	var pw2 = document.getElementById("mem_pw2");
	var birth = $("#year-button").html() + "-" + $("#month-button").html() + "-" + $("#date-button").html();
	var email = document.getElementById("mem_email");
	
	if(idFlag && pwFlag && pw2Flag && emailFlag && emailAccessFlag) {
		var header = $("#header").val();
		var token = $("#token").val();
		
		$.ajax({
			url: "${pageContext.request.contextPath}/join/joinOk",
			type: "POST",
			cache: false,
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			data: {
				"mem_id" : id.value,
				"mem_pw" : pw.value,
				"mem_birth" : birth,
				"mem_email" : email.value
			},
			success: function(data, status) {
				if(status == "success") {
					if(data == "Ok") {
						$("#myModal .modal-body").html("가입되었습니다.");
						$("#myModal .modal-footer button").attr("onclick", "location.href='${pageContext.request.contextPath}/'");
						$("#myModal").modal();
					} else {
						$("#myModal .modal-body").html("알 수 없는 오류입니다.");
						$("#myModal .modal-footer button").removeAttr("onclick");
						$("#myModal").modal();
					}
				}
			}
		});
	} else {
		checkID(id); checkPW(pw); checkPW2(pw2); accessEmailOk(); checkEmail(email);
	}
}
</script>
<style type="text/css">
html, body { height: 100%; }
.joinWrapper {
	height: 100%;
	background-color: rgba(246, 246, 246, 0.4);
}
.joinWrapper .joinInner {
	max-width: 550px;
	margin: auto;
	border: 1px solid #D5D5D5;
	background-color: white;
}
.joinWrapper .joinInner .on {
	display: block
}
.joinWrapper .joinInner .logo {
	padding: 20px 0;
	text-align: center;
}
.joinWrapper .joinInner .logo img {
	display: inline-block;
}
.joinWrapper .joinInner .dropdown-height {
	height: 200px;
	overflow: auto;
}
.Access-group {
	display: flex;
}
.Access-group .dropdown {
	flex-grow: 1;
	margin-right: 5px;
}
.Access-group .dropdown.last {
	margin-right: 0;
}
.Access-group .dropdown * {
	width: 100%;
}
.Access-group .dropdown button {
	background-color: white;
	color: black;
}
.Access-group #access_btn {
	width: 80px;
	margin-left: 5px;
}
.form-group.off {
	display: none;
}
</style>
</head>
<body>
<div class="joinWrapper">
	<div class="joinInner">
		<div class="logo">
			<a href="${pageContext.request.contextPath}/"><img class="img-fluid" src="${pageContext.request.contextPath}/resources/img/main/mainLogo2.png"/></a>
		</div>
		<div class="container">
			<form class="needs-validation">
				<div class="form-group">
					<label for="uname">아이디</label>
					<input type="text" class="form-control" id="mem_id" onkeyup="checkID(this);" onblur="checkID(this);" placeholder="Enter userid" name="mem_id"/>
				<div class="valid-feedback">올바른 입력입니다.</div>
				<div class="invalid-feedback">영문 대소문자 및 숫자를 포함하여 6자 이상 10자 이하로 작성해주세요.</div>
		    	</div>
		    	<div class="form-group">
		     		<label for="pwd">비밀번호</label>
		      		<input type="password" class="form-control" id="mem_pw" onkeyup="checkPW(this);" onblur="checkPW(this);" placeholder="Enter password" name="mem_pw"/>
		      		<div class="valid-feedback">올바른 입력입니다.</div>
		      		<div class="invalid-feedback">영문 대소문자 및 숫자, 특수문자를 조합하여 8자 이상 20자 이하로 작성해주세요.</div>
		    	</div>
		    	<div class="form-group">
		     		<label for="pwd">비밀번호 재확인</label>
		      		<input type="password" class="form-control" id="mem_pw2" onkeyup="checkPW2(this);" onblur="checkPW2(this);" placeholder="Re-Enter password" name="mem_pw2"/>
		      		<div class="valid-feedback">올바른 입력입니다.</div>
		      		<div class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
		    	</div>
		    	<div class="form-group">
		     		<label for="birthday">생년월일</label>
		      		<div class="Access-group">
					  <div class="dropdown">
					    <button id="year-button" type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">
					    </button>
					    <div id="year-dropdown" class="dropdown-menu dropdown-height">
					    </div>
					  </div>
					  <div class="dropdown">
					    <button id="month-button" type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">
					    </button>
					    <div id="month-dropdown" class="dropdown-menu dropdown-height">
					      <span class="dropdown-item"></span>
					    </div>
					  </div>
					  <div class="dropdown last">
					    <button id="date-button" type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">
					    </button>
					    <div id="date-dropdown" class="dropdown-menu dropdown-height">
					      <span class="dropdown-item"></span>
					    </div>
					  </div>
		      		</div>
		      		<div class="valid-feedback on">올바른 입력입니다.</div>
		    	</div>
		    	<div class="form-group">
		     		<label for="pwd">이메일</label>
		      		<input type="email" class="form-control" id="mem_email" onkeyup="checkEmail(this);" onblur="checkEmail(this);" onblur="checkEmail(this);" placeholder="Enter Email" name="mem_email"/>
		      		<div class="valid-feedback">올바른 입력입니다.</div>
		      		<div class="invalid-feedback">이메일 형식이 올바르지 않습니다.</div>
		    	</div>
		    	<div id="email-access-group" class="form-group off">
		    		<div class="Access-group">
		      		<input type="text" class="form-control" id="access_key" placeholder="Enter Access Email Key" name="access_key"/>
		      		<button id="access_btn" type="button" class="btn btn-secondary btn-grow" onclick="accessEmail(this);">요청</button>
		      		</div>
		      		<div class="valid-feedback">올바른 입력입니다.</div>
		      		<div class="invalid-feedback">이메일 인증키가 올바르지 않습니다.</div>
		    	</div>
		    	<div class="form-group">
		    		<button type="button" class="btn btn-info" onclick="joinSubmit();">가입하기</button>
		    	</div>
		    	</form>
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
		<input type="hidden" id="header" value="${_csrf.headerName}"/>
		<input type="hidden" id="token" value="${_csrf.token}"/>
	</div>
</div>
</body>
</html>
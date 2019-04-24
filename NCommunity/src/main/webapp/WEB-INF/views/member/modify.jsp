<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
function uploadProfile(file) {
	var fileSize = file.files[0].size / 1024 / 1024;
	var fileName = file.files[0].name;
	var fileNameArr = file.files[0].name.split("\.");
	var fileExt = fileNameArr[fileNameArr.length-1];
	
	if(!($.inArray(fileExt, ["jpg", "jpeg", "png", "PNG", "gif"]) >= 0)) {
		$("#myModal .modal-body").html("허용되지 않는 확장자입니다.");
		$("#myModal .modal-footer").removeAttr("onclick");
		$("#myModal").modal();
		return false;
	}
	
	if(fileSize > 10) {
		$("#myModal .modal-body").html("최대 10MB의 이미지만 등록할 수 있습니다.");
		$("#myModal .modal-footer").removeAttr("onclick");
		$("#myModal").modal();
		return false;
	}
	
	var header = $("#header").val();
	var token = $("#token").val();
	
	var formData = new FormData();
	formData.append("uploadProfile", file.files[0]);
	formData.append("mem_num", ${empty sessionScope.num? 0:sessionScope.num});
	
	$.ajax({
		url: "${pageContext.request.contextPath}/rMember/profile",
		type: "POST",
		cache: false,
		data: formData,
		processData: false,
		contentType: false,
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(data, status) {
			if(status == "success") {
				if(data != "Fail") {
					$(".profile-img .profile").attr("src", "${pageContext.request.contextPath}/resources/profile/" + data + "");
				}
			}
		}
	});
}
function nickname() {
	var nickname = $("#nickname").val();
	
	if(nickname == null || nickname == "" || nickname.length < 3 || nickname.length > 12) {
		$("#myModal .modal-body").html("닉네임은 3자 이상 12자 이하로 입력해주세요.");
		$("#myModal .modal-footer").removeAttr("onclick");
		$("#myModal").modal();
		return false;
	}
	
	var header = $("#header").val();
	var token = $("#token").val();
	
	$.ajax({
		url: "${pageContext.request.contextPath}/rMember/nickname",
		type: "POST",
		cache: false,
		data: {
			"nickname" : nickname,
			"mem_num" : ${empty sessionScope.num? 0:sessionScope.num}
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token)
		},
		success: function(data, status) {
			if(status == "success") {
				if(data != "Fail") {
					$("#myModal .modal-body").html("변경되었습니다.");
					$("#myModal .modal-footer").removeAttr("onclick");
					$("#myModal").modal();
					$("#nickname").val(data);
				} else {
					$("#myModal .modal-body").html("알 수 없는 오류입니다.");
					$("#myModal .modal-footer").removeAttr("onclick");
					$("#myModal").modal();
				}
			}
		}
	});
}
</script>
<style>
.off {
	display: none;
}
.margin {
	padding: 10px;
	border: 1px solid #D5D5D5;
	border-radius: 5px;
}
.profile-box .profile-img {
	width: 100px;
	height: 100px;
	margin: auto;
	margin-bottom: 5px;
	border: 1px solid #D5D5D5;
	border-radius: 50px; 
}
.profile-box .profile-img img {
	width: 100%;
	height: 100%;
	border-radius: 50px;
}
.cursor {
	margin-bottom: 0;
	cursor: pointer;
}
.profile-box .profile-btn {
	text-align: center;
}
.info-box {
	display: flex;
	height: 100%;
	align-items: center;
}
@media (max-width:991px) {
	#nickname, #nickname-btn {
		margin-top: 5px;
	}
}
</style>
<div class="jumbotron" style="margin-top: 15px; padding: 10px;">
	<h3>회원정보 수정</h3>
</div>
<div class="form-group margin">
	<div class="row">
		<div class="col-sm-12 col-lg-3">
			<div class="profile-box">
				<div class="profile-img">
					<c:choose>
						<c:when test="${not empty dto.mem_profile}">
							<img class="profile" src="${pageContext.request.contextPath}/resources/profile/${dto.mem_profile}"/>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="profile-btn">
					<label class="btn btn-outline-secondary cursor" for="profile">사진변경</label>
					<input class="off" type="file" id="profile" onchange="uploadProfile(this);" />
				</div>
			</div>
		</div>
		<div class="col-sm-12 col-lg-9">
		<div class="info-box">
			<div class="input-group mb-3">
    			<input type="text" class="form-control" id="nickname" value="${dto.mem_nickname=='NONE'? '':dto.mem_nickname}" placeholder="닉네임을 입력하세요.">
    			<div class="input-group-append">
      				<button class="btn btn-primary" id="nickname-btn" type="button" onclick="nickname();">OK</button>  
     			</div>
  			</div>
			</div>
		</div>
	</div>
</div>
<input type="hidden" id="header" value="${_csrf.headerName}"/>
<input type="hidden" id="token" value="${_csrf.token}"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdn.ckeditor.com/ckeditor5/12.0.0/classic/ckeditor.js"></script>
<script>
$(document).ready(function() {
	if(getClientInfo().name == "Safari" || "Firefox" || "IE") {
		if(getClientInfo().name == "Safari") {		
			$("#myModal .modal-body").html("Safari 브라우저를 이용하고 계십니다.<br>해당 브라우저는 일부 기능이 정상적으로 호환되지 않으므로<br>Edge 또는 Chrome 브라우저를 이용해주세요.");
			$("#myModal .modal-footer").attr("onclick", "history.back();");
			$("#myModal").modal();
		} else if(getClientInfo().name == "Firefox") {
			$("#myModal .modal-body").html("Firefox 브라우저를 이용하고 계십니다.<br>해당 브라우저는 일부 기능이 정상적으로 호환되지 않으므로<br>Edge 또는 Chrome 브라우저를 이용해주세요.");
			$("#myModal .modal-footer").attr("onclick", "history.back();");
			$("#myModal").modal();
		} else if(getClientInfo().name == "IE") {
			$("#myModal .modal-body").html("Internet Explorer 브라우저를 이용하고 계십니다.<br>해당 브라우저는 일부 기능이 정상적으로 호환되지 않으므로<br>Edge 또는 Chrome 브라우저를 이용해주세요.");
			$("#myModal .modal-footer").attr("onclick", "history.back();");
			$("#myModal").modal();
		}
	}
});
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
function writeSubmit(form) {
	var subject = form["subject"].value;
	var content = myEditor.getData();
	
	if(subject == null || subject == "" || subject.length < 10 || subject.length > 100) {
		$("#myModal .modal-body").html("제목은 10자 이상 100자 이하로 입력해주세요.");
		$("#myModal").modal();
		return false;
	}
	if(content == null || content == "" || content.length == 0) {
		$("#myModal .modal-body").html("내용을 입력해주세요.");
		$("#myModal").modal();
		return false;
	}
}
</script>
<style>
.form-group.margin {
	margin-top: 15px;
}
.ck-editor__editable[role="textbox"] {
	height: 500px;
}
</style>
<form action="${pageContext.request.contextPath}/board/updateOk" id="writeForm" onsubmit="return writeSubmit(this);" method="post">
	<div class="form-group margin subject">
		<input type="text" class="form-control" id="subject" placeholder="제목은 10자 이상 100자 이하로 입력해주세요." name="subject" value="${dto.subject}"/>
	</div>
	<textarea id="content" name="content" placeholder="내용을 입력해주세요.">${dto.content}</textarea>
	<div class="form-group margin function">
		<button type="submit" class="btn btn-outline-primary">작성하기</button>
		<button type="button" class="btn btn-outline-secondary" onclick="history.back();">이전으로</button>
	</div>
	<input type="hidden" id="mem_num" name="mem_num" value="${sessionScope.num}"/>
	<input type="hidden" id="num" name="num" value="${dto.num}"/>
	<input type="hidden" id="type" name="type" value="${param.type}"/>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>
<input type="hidden" id="header" value="${_csrf.headerName}"/>
<input type="hidden" id="token" value="${_csrf.token}"/>
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
<script>
ClassicEditor
	.create( document.querySelector('#content'), {
		ckfinder: {
	        uploadUrl: '${pageContext.request.contextPath}/upload/img?${_csrf.parameterName}=${_csrf.token}'
	    },
		removePlugins: ['MediaEmbed']
	})
	.then( editor => {
	    myEditor = editor;
	})
	.catch( error => {
		console.error( error );
	});
</script>
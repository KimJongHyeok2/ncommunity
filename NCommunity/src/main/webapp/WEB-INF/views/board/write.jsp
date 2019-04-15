<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdn.ckeditor.com/ckeditor5/12.0.0/classic/ckeditor.js"></script>
<script>
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
<form action="${pageContext.request.contextPath}/board/writeOk" id="writeForm" onsubmit="return writeSubmit(this);" method="post">
	<div class="form-group margin subject">
		<input type="text" class="form-control" id="subject" placeholder="제목은 10자 이상 100자 이하로 입력해주세요." name="subject"/>
	</div>
	<textarea id="content" name="content" placeholder="내용을 입력해주세요."></textarea>
	<div class="form-group margin function">
		<button id="submit" type="submit" class="btn btn-outline-primary">작성하기</button>
		<button type="button" class="btn btn-outline-secondary">이전으로</button>
	</div>
	<input type="hidden" id="num" name="num" value="${sessionScope.num}"/>
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
	    }
	})
	.then( editor => {
	    myEditor = editor;
	})
	.catch( error => {
		console.error( error );
});
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdn.ckeditor.com/ckeditor5/12.0.0/classic/ckeditor.js"></script>
<script>
$(document).ready(function() {
	
});
function testT() {
	alert(myEditor.getData());
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
<div class="form-group margin subject">
	<input type="text" class="form-control" id="subject" placeholder="Enter Subject" name="subject"/>
</div>
<textarea id="content"></textarea>
<div class="form-group margin function">
	<button id="submit" type="button" class="btn btn-outline-primary" onclick="testT();">작성하기</button>
	<button type="button" class="btn btn-outline-secondary">이전으로</button>
</div>
<script>
ClassicEditor
	.create( document.querySelector('#content'), {
		ckfinder: {
	        uploadUrl: '${pageContext.request.contextPath}/upload/img'
	    }
	})
	.then( editor => {
	    console.log( 'Editor was initialized', editor);
	    myEditor = editor;
	})
	.catch( error => {
		console.error( error );
});
</script>
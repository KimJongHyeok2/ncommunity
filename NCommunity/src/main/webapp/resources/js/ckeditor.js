ClassicEditor
	.create( document.querySelector('#content'), {
		ckfinder: {
	        uploadUrl: '${pageContext.request.contextPath}/upload/img'
	    }
	})
    .then( editor => {
        console.log( 'Editor was initialized', editor );
        myEditor = editor;
    })
	.catch( error => {
		console.error( error );
	});
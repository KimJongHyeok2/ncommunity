<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(document).ready(function() {
	var today = new Date();
	var tYear = today.getFullYear();
	var tMonth = today.getMonth()+1;
	tMonth = (tMonth + "").length==1? ("0" + tMonth):tMonth;
	var tDate = today.getDate();
	tDate = (tDate.length + "")==1? ("0" + tDate):tDate;
		
	var regdate = new Date($("#regdate").html().replace(/-/g, "/").replace(".0", ""));
	var rYear = regdate.getFullYear();
	var rMonth = regdate.getMonth()+1;
	rMonth = (rMonth + "").length==1? ("0" + rMonth):rMonth;
	var rDate = regdate.getDate();
	rDate = (rDate.length + "")==1? ("0" + rDate):rDate;

	if((tYear + "-" + tMonth + "-" + tDate) == (rYear + "-" + rMonth + "-" + rDate)) {
		var hour = regdate.getHours();
		hour = (hour + "").length==1? ("0" + hour):hour;
		var minute = regdate.getMinutes();
		minute = (minute + "").length==1? ("0" + minute):minute;
		$("#regdate").html(hour + ":" + minute);
	} else {
		$("#regdate").html(rMonth + "-" + rDate);
	}
	$(".v-content img").addClass("img-fluid");
	
	if(${empty dto || dto.status != 1}) {
		$("#myModal .modal-body").html("삭제되었거나 존재하지 않는 글입니다.");
		$("#myModal .modal-footer").attr("onclick", "history.back();")
		$("#myModal").modal();
	}

	$("oembed[url]").each(function() {
 		 const anchor = document.createElement("a");
 		 anchor.setAttribute('href', $(this).attr("url"));
 		 anchor.className = 'embedly-card';
 		 $(this).css("width", "100%");
 		 
 		 $(this).append(anchor);
	});
	
	$("figure").css("margin", "0");
	/* 	document.querySelectorAll( 'oembed[url]' ).forEach( element => {

	    const anchor = document.createElement( 'a' );
	    anchor.setAttribute( 'href', element.getAttribute( 'url' ) );
	    anchor.className = 'embedly-card';
	    element.appendChild( anchor );
	    
	});	 */
	commentList(0, 'new');
	$(".popular-list").click(function() {
		commentList(0, 'popular');
	});
	$(".new-list").click(function() {
		commentList(0, 'new');
	});
});
function deleteConfirm() {
	$("#myModal2 .modal-body").html("정말로 글을 삭제하시겠습니까?");
	$("#delete-btn").attr("onclick", "$('#delete-form').submit();");
	$("#myModal2").modal();
}
function list(type) {
 	type = type.substr(-type.length, 4) + "Board-New";
	location.href = "${pageContext.request.contextPath}/board?type=" + type;
}
function recommend(num, mem_num, recommendtype) {
	if(num == 0 || mem_num == 0) {
		$("#myModal .modal-body").html("로그인이 필요합니다.");
		$("#myModal .modal-footer").removeAttr("onclick");
		$("#myModal").modal();
		return false;
	}
	
	var header = $("#header").val();
	var token = $("#token").val();
	var board_type = '${param.type}';
	board_type = board_type.substr(-board_type.length, 4) + "Board";

	if(${not empty sessionScope.num}) {
		$.ajax({
			url: "${pageContext.request.contextPath}/rBoard/recommend",
			type: "POST",
			cache: false,
			data: {
				"num" : num,
				"mem_num" : mem_num,
				"recommendtype" : recommendtype,
				"board_type" : board_type
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function(data, status) {
				if(status == "success") {
					if(data == "1") {
						$("#like-count").html((parseInt($("#like-count").html()) + 1));
						$("#myModal .modal-body").html("좋아요를 눌렀습니다.");
						$("#myModal .modal-footer").removeAttr("onclick");
						$("#myModal").modal();
					} else if(data == "2") {
						$("#hate-count").html((parseInt($("#hate-count").html()) + 1));
						$("#myModal .modal-body").html("싫어요를 눌렀습니다.");
						$("#myModal .modal-footer").removeAttr("onclick");
						$("#myModal").modal();						
					} else if(data == "Already-Like") {
						$("#myModal .modal-body").html("이미 좋아요를 누른 글입니다.");
						$("#myModal .modal-footer").removeAttr("onclick");
						$("#myModal").modal();
					} else if(data == "Already-Hate") {
						$("#myModal .modal-body").html("이미 싫어요를 누른 글입니다.");
						$("#myModal .modal-footer").removeAttr("onclick");
						$("#myModal").modal();
					} else {
						$("#myModal .modal-body").html("알 수 없는 오류입니다.");
						$("#myModal .modal-footer").removeAttr("onclick");
						$("#myModal").modal();
					}
				}
			}
		});
	} else {
		$("#myModal .modal-body").html("로그인이 필요합니다.");
		$("#myModal .modal-footer").attr("onclick", "location.href='${pageContext.request.contextPath}/'");
		$("#myModal").modal();	
	}
}
function commentRecommend(num, mem_num, recommendtype) {
	if(num == 0 || mem_num == 0) {
		$("#myModal .modal-body").html("로그인이 필요합니다.");
		$("#myModal .modal-footer").removeAttr("onclick");
		$("#myModal").modal();
		return false;
	}
	
	var header = $("#header").val();
	var token = $("#token").val();
	var comment_type = '${param.type}';
	comment_type = comment_type.substr(-comment_type.length, 4) + "Comment";
	
	if(${not empty sessionScope.num}) {
		$.ajax({
			url: "${pageContext.request.contextPath}/rBoard/commentRecommend",
			type: "POST",
			cache: false,
			data: {
				"num" : num,
				"mem_num" : mem_num,
				"recommendtype" : recommendtype,
				"comment_type" : comment_type
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function(data, status) {
				if(status == "success") {
					if(data == "3") {
						$("#comment-like-count-" + num).html((parseInt($("#comment-like-count-" + num).html()) + 1));
						$("#myModal .modal-body").html("좋아요를 눌렀습니다.");
						$("#myModal .modal-footer").removeAttr("onclick");
						$("#myModal").modal();
					} else if(data == "4") {
						$("#comment-hate-count-" + num).html((parseInt($("#comment-hate-count-" + num).html()) + 1));
						$("#myModal .modal-body").html("싫어요를 눌렀습니다.");
						$("#myModal .modal-footer").removeAttr("onclick");
						$("#myModal").modal();						
					} else if(data == "Already-Like") {
						$("#myModal .modal-body").html("이미 좋아요를 누른 댓글입니다.");
						$("#myModal .modal-footer").removeAttr("onclick");
						$("#myModal").modal();
					} else if(data == "Already-Hate") {
						$("#myModal .modal-body").html("이미 싫어요를 누른 댓글입니다.");
						$("#myModal .modal-footer").removeAttr("onclick");
						$("#myModal").modal();
					} else {
						$("#myModal .modal-body").html("알 수 없는 오류입니다.");
						$("#myModal .modal-footer").removeAttr("onclick");
						$("#myModal").modal();
					}
				}
			}
		});
	} else {
		$("#myModal .modal-body").html("로그인이 필요합니다.");
		$("#myModal .modal-footer").attr("onclick", "location.href='${pageContext.request.contextPath}/'");
		$("#myModal").modal();	
	}
}
function limitComment(comment) {
	var commentVal = comment.value;
	$("#comment-write").attr("onclick", "commentWrite();");
	$(".alert-info.comment").removeClass("animated bounce");
	
	if(commentVal.length > 300) {
		$(comment).val(commentVal.substr(0, 300));
		$(".alert-info.comment").css("display", "block").animate({"opacity":"1"}, 1000);
	} else if(commentVal.length < 10) {
		$(".alert-info.comment").css("display", "block").animate({"opacity":"1"}, 1000);
	}
	
	$("#comment-limit").html(commentVal.length);
}
function limitReComment(recomment, num) {
	var recommentVal = recomment.value;

	$("#recomment-write-" + num).attr("onclick", "recommentWrite(" + num + ");");
	
	if(recommentVal.length > 300) {
		$(recomment).val(recommentVal.substr(0, 300));
	}
	
	$("#recomment-limit-" + num).html(recommentVal.length);
}
function commentWrite() {
	if(${empty sessionScope.num}) {
		$("#myModal .modal-body").html("로그인이 필요합니다.");
		$("#myModal .modal-footer").removeAttr("onclick");
		$("#myModal").modal();
		return false;
	}
	
	var comment = $("#comment").val();
	var type = '${param.type}';
	type = type.substr(-type.length, 4) + "Comment";
	
	if(comment.length < 10) {
		$(".alert-info.comment").addClass("animated bounce");
	} else if(comment.length > 300) {
		$(".alert-info.comment").addClass("animated bounce");
	} else {
		if(comment.length < 10 || comment.length > 300) {
			$(".alert-info.comment").addClass("animated bounce");
			return false;
		}

		var header = $("#header").val();
		var token = $("#token").val();
		
		$.ajax({
			url: "${pageContext.request.contextPath}/rBoard/insertComment",
			type: "POST",
			cache: false,
			data: {
				"board_num" : ${empty dto.num? 0:dto.num},
				"mem_num" : ${empty sessionScope.num? 0:sessionScope.num},
				"content" : comment,
				"type" : type
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function(data, status) {
				if(status == "success") {
					if(data == "Ok") {
						$("#comment").val("");
						$("#comment-limit").html("0");
						commentList(0, 'new');
						$(".alert-info.comment").animate({"opacity":"0"}, 1000).css("display", "none");
					}
				}
			}
		});
	}
}
function recommentWrite(num) {
	if(${empty sessionScope.num}) {
		$("#myModal .modal-body").html("로그인이 필요합니다.");
		$("#myModal .modal-footer").removeAttr("onclick");
		$("#myModal").modal();
		return false;
	}
	
	var recomment = $("#recomment-" + num).val();
	var type = '${param.type}';
	type = type.substr(-type.length, 4) + "ReComment";
	
	if(recomment.length < 10) {
		$("#myModal .modal-body").html("답글은 10자 이상 300자 이하로 입력해주세요.");
		$("#myModal .modal-footer").removeAttr("onclick");
		$("#myModal").modal();
	} else if(recomment.length > 300) {
		$("#myModal .modal-body").html("답글은 10자 이상 300자 이하로 입력해주세요.");
		$("#myModal .modal-footer").removeAttr("onclick");
		$("#myModal").modal();
	} else {
		if(recomment.length < 10 || recomment.length > 300) {
			$("#myModal .modal-body").html("답글은 10자 이상 300자 이하로 입력해주세요.");
			$("#myModal .modal-footer").removeAttr("onclick");
			$("#myModal").modal();
			return false;
		}
		
		var header = $("#header").val();
		var token = $("#token").val();
		
		$.ajax({
			url: "${pageContext.request.contextPath}/rBoard/insertReComment",
			type: "POST",
			cache: false,
			data: {
				"comment_num" : num,
				"board_num" : ${empty dto.num? 0:dto.num},
				"mem_num" : ${empty sessionScope.num? 0:sessionScope.num},
				"content" : recomment,
				"type" : type
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function(data, status) {
				if(status == "success") {
					if(data == "Ok") {
						$("#recomment").val("");
						$("#recomment-limit").html("0");
						commentList(num, 'new');
						$(".recomment-list").css("display", "block");
					} else {
						$("#myModal .modal-body").html("알 수 없는 오류입니다.");
						$("#myModal .modal-footer").removeAttr("onclick");
						$("#myModal").modal();
					}
				}
			}
		});
	}
}
function commentList(displayNumber, list_type) {
	var header = $("#header").val();
	var token = $("#token").val();
	var type = "${param.type}";
	type = type.substr(-type.length, 4) + "Comments";
	
	$.ajax({
		url: "${pageContext.request.contextPath}/rBoard/selectComments",
		type: "POST",
		cache: false,
		data: {
			"type" : type,
			"list_type" : list_type,
			"num" : ${empty dto.num? 0:dto.num}
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(data, status) {
			if(status == "success") {
				if(data.status == "Ok") {
					var commentHTML = "";
					var commentCount = 0;
					for(var i=0; i<data.count; i++) {
						commentHTML += "<div class='container-comment-list'>";
							commentHTML += "<ul class='comment-list'>";
								if(data.list[i].status == 1) {
									commentCount += 1;
									commentHTML += "<li>";
									commentHTML += "<div class='comment-subject'>";
										commentHTML += "<div class='subject'>";
											commentHTML += data.list[i].nickname + "(<span>" + data.list[i].id + "</span>)";
										commentHTML += "</div>";
										commentHTML += "<div class='regdate'>";
											commentHTML += formatRegDate(data.list[i].regdate);
										commentHTML += "</div>";
									commentHTML += "</div>";
									commentHTML += "<div class='comment-content'>";
										commentHTML += "<div id='c-content-" + data.list[i].num + "' class='c-content'>";
											if(list_type == "popular") {
												commentHTML += "<span class='badge badge-danger'>BEST</span> " + data.list[i].content.replace(/\n/g, "<br>");
											} else {
												commentHTML += data.list[i].content.replace(/\n/g, "<br>");												
											}
										commentHTML += "</div>";
									commentHTML += "</div>";
									commentHTML += "<div class='recommend'>";
										commentHTML += "<div class='btn-group'>";
											commentHTML += "<button type='button' class='btn btn-info' onclick='recommentToggle(" + data.list[i].num + ");'>답글(<span id='recomment-count-" + data.list[i].num + "'>0</span>)</button>";
											commentHTML += "<button type='button' class='btn btn-info dropdown-toggle dropdown-toggle-split' onclick='recommentToggle(" + data.list[i].num + ");'>";
												commentHTML += "<span class='caret'></span>";
											commentHTML += "</button>";
										commentHTML += "</div>";
										commentHTML += "<button type='button' class='btn btn-primary comment-like' onclick='commentRecommend(" + data.list[i].num + ", ${sessionScope.num}, 3);'>";
											commentHTML += "<span><img class='recommend-img' src='${pageContext.request.contextPath}/resources/img/board/like.png'/></span> <span id='comment-like-count-" + data.list[i].num + "' class='badge badge-light'>" + data.list[i].like + "</span>";
										commentHTML += "</button>";
										commentHTML += "<button type='button' class='btn btn-danger comment-dislike' onclick='commentRecommend(" + data.list[i].num + ", ${sessionScope.num}, 4);'>";
											commentHTML += "<span><img class='recommend-img' src='${pageContext.request.contextPath}/resources/img/board/dislike.png'/></span> <span id='comment-hate-count-" + data.list[i].num + "' class='badge badge-light'>" + data.list[i].hate + "</span>";
										commentHTML += "</button>";
										commentHTML += "<div class='btn-group float-right'>";
											commentHTML += "<button type='button' id='comment-update-btn-" + data.list[i].num + "' class='btn btn-outline-primary " + mine(data.list[i].mem_num) + "' onclick='updateComment(" + data.list[i].num + ")'>수정</button>";
											commentHTML += "<button type='button' id='comment-delete-btn-" + data.list[i].num + "' class='btn btn-outline-danger " + mine(data.list[i].mem_num) + "' onclick='deleteComment(" + data.list[i].num + ")'>삭제</button>";
										commentHTML += "</div>";
									commentHTML += "</div>";
									commentHTML += "</li>";
								} else {
									commentHTML += "<li>";
									commentHTML += "<div class='deleteComment'>사용자에 의해 삭제된 댓글입니다.</div>";
									commentHTML += "</li>";
								}
							commentHTML += "</ul>";
							commentHTML += "<ul id='recomment-list-" + data.list[i].num + "' class='recomment-list " + (displayNumber != null && displayNumber == data.list[i].num? 'onRecomment':'') + "'>";
							commentHTML += "</ul>";
						commentHTML += "</div>";
					}
					if(data.count != 0) {
						$("#container-comment").html(commentHTML);
						if(list_type == "new") {					
							$("#comment-count").html(commentCount);
						}
					} else {
						$("#container-comment").html("<div class='empty-comment'>등록된 댓글이 없습니다.</div>");
					}
				} else {
					$("#container-comment").html("<div class='empty-comment'>등록된 댓글이 없습니다.</div>");
				}
			}
		}
	});
	recommentList(list_type);
}
function recommentList(list_type) {
	var header = $("#header").val();
	var token = $("#token").val();
	var type_re = "${param.type}";
	type_re = type_re.substr(-type_re.length, 4) + "ReComments";
	
	
	$.ajax({
		url: "${pageContext.request.contextPath}/rBoard/selectReComments",
		type: "POST",
		cache: false,
		data: {
			"type" : type_re,
			"num" : ${empty dto.num? 0:dto.num}
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(data, status) {
			if(status == "success") {
				if(data.status == "Ok") {
					var recommentCount = 0;
					for(var i=0; i<data.commentCount.commentsCount; i++) {
						var recommentHTML = "";
							recommentHTML += "<li>";
								recommentHTML += "<div class='container-comment-input recomment'>";
									recommentHTML += "<textarea class='form-control' rows='3' id='recomment-" + data.commentCount.list[i].num + "' onkeyup='limitReComment(this, " + data.commentCount.list[i].num + ");' placeholder='내용을 입력해주세요.'></textarea>";
									recommentHTML += "(<span id='recomment-limit-" + data.commentCount.list[i].num + "' class='margin'>0</span>/300)";
									recommentHTML += "<button type='button' id='recomment-write-" + data.commentCount.list[i].num + "' class='btn btn-outline-primary float-right margin'>작성하기</button>";
								recommentHTML += "</div>";
							recommentHTML += "</li>";
							for(var j=0; j<data.count; j++) {
								if(data.commentCount.list[i].num == data.list[j].comment_num) {
									recommentHTML += "<li>";
										recommentHTML += "<div class='recomment-content'>";
											recommentHTML += "<div class='arrow'><img src='${pageContext.request.contextPath}/resources/img/board/arrow.png'/></div>";
											if(data.list[j].status == 1) {
												$("#recomment-count-" + data.commentCount.list[i].num).html((parseInt($("#recomment-count-" + data.commentCount.list[i].num).html()) + 1));
												recommentCount += 1;
												recommentHTML += "<div class='rc-content'>";
													recommentHTML += "<div class='rc-subject'>";
														recommentHTML += "<div class='subject'>";
															recommentHTML += data.list[j].nickname + "(<span>" + data.list[j].id + "</span>)";
														recommentHTML += "</div>";
														recommentHTML += "<div class='regdate'>";
															recommentHTML += formatRegDate(data.list[j].regdate);
														recommentHTML += "</div>";
													recommentHTML += "</div>";
													recommentHTML += "<div class='rc-content-inner'>";
														recommentHTML += "<div id='rc-content-inner-content-" + data.list[j].num + "' class='rc-content-inner-content'>";
															recommentHTML += data.list[j].content.replace(/\n/g, "<br>");
														recommentHTML += "</div>";
														recommentHTML += "<div class='btn-group " +  mine(data.list[j].mem_num) + " float-right'>";
															recommentHTML += "<button type='button' id='recomment-update-btn-" + data.list[j].num + "' class='btn btn-outline-primary'" + mine(data.list[j].mem_num) + "' onclick='updateReComment(" + data.list[j].num + ")'>수정</button>";
															recommentHTML += "<button type='button' id='recomment-delete-btn-" + data.list[j].num + "' class='btn btn-outline-danger'" + mine(data.list[j].mem_num) + "' onclick='deleteReComment(" + data.list[j].num + ")'>삭제</button>";
														recommentHTML += "</div>";
													recommentHTML += "</div>";
												recommentHTML += "</div>";
											} else {
												recommentHTML += "<div class='deleteReComment'>";
													recommentHTML += "<div>사용자에 의해 삭제된 답글입니다.</div>";
												recommentHTML += "</div>";
											}
										recommentHTML += "</div>";
									recommentHTML += "</li>";
								}
							}
						$("#recomment-list-" + data.commentCount.list[i].num).html(recommentHTML);
					}
					if(list_type == "new") {						
						$("#comment-count").html((parseInt($("#comment-count").html()) + recommentCount));
					}
				}
			}
		}
	});
}
function updateComment(num) {
	var tempHTML = $("#c-content-" + num).html().replace(/<br>/g, "\n");
	$("#c-content-" + num).html("<textarea id='comment-update-input-" + num + "' class='form-control' rows='2'>" + tempHTML + "</textarea>");
	$("#comment-update-btn-" + num).html("확인");
	$("#comment-delete-btn-" + num).html("취소");
	$("#comment-update-btn-" + num).attr("onclick", "updateCommentOk(" + num + ")");
	tempHTML = tempHTML.replace(/\n/g, "<br>");
	$("#comment-delete-btn-" + num).attr("onclick", "updateCommentCancle(" + num + ", '" + tempHTML + "')");
}
function updateCommentOk(num) {
	var comment = $("#comment-update-input-" + num).val();
	var header = $("#header").val();
	var token = $("#token").val();
	var type = "${param.type}";
	type = type.substr(-type.length, 4) + "Comment";
	
	if(comment.length < 10) {
		$("#myModal .modal-body").html("댓글은 10자 이상 300자 이하로 입력해주세요.");
		$("#myModal .modal-footer").removeAttr("onclick");
		$("#myModal").modal();
	} else if(comment.length > 300) {
		$("#myModal .modal-body").html("댓글은 10자 이상 300자 이하로 입력해주세요.");
		$("#myModal .modal-footer").removeAttr("onclick");
		$("#myModal").modal();
	} else {
		$.ajax({
			url: "${pageContext.request.contextPath}/rBoard/updateComment",
			type: "POST",
			cache: false,
			data: {
				"type" : type,
				"num" : num,
				"content" : comment
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function(data, status) {
				if(status == "success") {
					if(data != "Fail") {
						$("#c-content-" + num).html(data);
						$("#comment-update-btn-" + num).html("수정");
						$("#comment-delete-btn-" + num).html("삭제");
						$("#comment-update-btn-" + num).attr("onclick", "updateComment(" + num + ")");	
						$("#comment-delete-btn-" + num).attr("onclick", "deleteComment(" + num + ")");	
					}
				}
			}
		});
	}
}
function deleteComment(num) {
	$("#myModal2 .modal-body").html("정말로 댓글을 삭제하시겠습니까?");
	$("#delete-btn").attr("onclick", "deleteCommentOk(" + num + ")");
	$("#myModal2").modal();
}
function deleteCommentOk(num) {
	$("#delete-btn-c").click();
	var header = $("#header").val();
	var token = $("#token").val();
	var type = "${param.type}";
	type = type.substr(-type.length, 4) + "Comment";
	
	$.ajax({
		url: "${pageContext.request.contextPath}/rBoard/deleteComment",
		type: "POST",
		cache: false,
		data: {
			"type" : type,
			"num" : num
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(data, status) {
			if(status == "success") {
				if(data == "Ok") {
					commentList(0, 'new');
				} else {
					$("#myModal .modal-body").html("이미 삭제되었거나 존재하지 않는 댓글입니다.");
					$("#myModal .modal-footer").removeAttr("onclick");
					$("#myModal").modal();
				}
			}
		}
	});
}
function updateCommentCancle(num, tempHTML) {
	$("#c-content-" + num).html(tempHTML);
	$("#comment-update-btn-" + num).html("수정");
	$("#comment-delete-btn-" + num).html("삭제");
	$("#comment-update-btn-" + num).attr("onclick", "updateComment(" + num + ")");	
	$("#comment-delete-btn-" + num).attr("onclick", "deleteComment(" + num + ")");	
}
function updateReComment(num) {
	var tempHTML = $("#rc-content-inner-content-" + num).html().replace(/<br>/g, "\n");
	$("#rc-content-inner-content-" + num).html("<textarea id='recomment-update-input-" + num + "' class='form-control' rows='2'>" + tempHTML + "</textarea>");
	$("#recomment-update-btn-" + num).html("확인");
	$("#recomment-delete-btn-" + num).html("취소");
	$("#recomment-update-btn-" + num).attr("onclick", "updateReCommentOk(" + num + ")");
	tempHTML = tempHTML.replace(/\n/g, "<br>");
	$("#recomment-delete-btn-" + num).attr("onclick", "updateReCommentCancle(" + num + ", '" + tempHTML + "')");
}
function updateReCommentOk(num) {
	var recomment = $("#recomment-update-input-" + num).val();
	var header = $("#header").val();
	var token = $("#token").val();
	var type = "${param.type}";
	type = type.substr(-type.length, 4) + "Comment";
	
	if(recomment.length < 10) {
		$("#myModal .modal-body").html("답글은 10자 이상 300자 이하로 입력해주세요.");
		$("#myModal .modal-footer").removeAttr("onclick");
		$("#myModal").modal();
	} else if(recomment.length > 300) {
		$("#myModal .modal-body").html("답글은 10자 이상 300자 이하로 입력해주세요.");
		$("#myModal .modal-footer").removeAttr("onclick");
		$("#myModal").modal();
	} else {
		$.ajax({
			url: "${pageContext.request.contextPath}/rBoard/updateReComment",
			type: "POST",
			cache: false,
			data: {
				"type" : type,
				"num" : num,
				"content" : recomment
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function(data, status) {
				if(status == "success") {
					if(data != "Fail") {
						$("#rc-content-inner-content-" + num).html(data);
						$("#recomment-update-btn-" + num).html("수정");
						$("#recomment-delete-btn-" + num).html("삭제");
						$("#recomment-update-btn-" + num).attr("onclick", "updateReComment(" + num + ")");
						$("#recomment-delete-btn-" + num).attr("onclick", "deleteReComment(" + num + ")");
					}
				}
			}
		});
	}
}
function updateReCommentCancle(num, tempHTML) {
	$("#rc-content-inner-content-" + num).html(tempHTML);
	$("#recomment-update-btn-" + num).html("수정");
	$("#recomment-delete-btn-" + num).html("삭제");
	$("#recomment-update-btn-" + num).attr("onclick", "updateReComment(" + num + ")");	
	$("#recomment-delete-btn-" + num).attr("onclick", "deleteReComment(" + num + ")");
}
function deleteReComment(num) {
	$("#myModal2 .modal-body").html("정말로 답글을 삭제하시겠습니까?");
	$("#delete-btn").attr("onclick", "deleteReCommentOk(" + num + ")");
	$("#myModal2").modal();
}
function deleteReCommentOk(num) {
	$("#delete-btn-c").click();
	var header = $("#header").val();
	var token = $("#token").val();
	var type = "${param.type}";
	type = type.substr(-type.length, 4) + "Comment";
	
	$.ajax({
		url: "${pageContext.request.contextPath}/rBoard/deleteReComment",
		type: "POST",
		cache: false,
		data: {
			"type" : type,
			"num" : num
		},
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(data, status) {
			if(status == "success") {
				if(data == "Ok") {
					commentList(0, 'new');
				} else {
					$("#myModal .modal-body").html("이미 삭제되었거나 존재하지 않는 답글입니다.");
					$("#myModal .modal-footer").removeAttr("onclick");
					$("#myModal").modal();
				}
			}
		}
	});
}
function formatRegDate(regdate) {
	var today = new Date();
	var tYear = today.getFullYear();
	var tMonth = today.getMonth()+1;
	tMonth = (tMonth + "").length==1? ("0" + tMonth):tMonth;
	var tDate = today.getDate();
	tDate = (tDate.length + "")==1? ("0" + tDate):tDate;
		
	var regdate = new Date(regdate);
	var rYear = regdate.getFullYear();
	var rMonth = regdate.getMonth()+1;
	rMonth = (rMonth + "").length==1? ("0" + rMonth):rMonth;
	var rDate = regdate.getDate();
	rDate = (rDate.length + "")==1? ("0" + rDate):rDate;
	
	var returnValue = "";
	
	if((tYear + "-" + tMonth + "-" + tDate) == (rYear + "-" + rMonth + "-" + rDate)) {
		var hour = regdate.getHours();
		hour = (hour + "").length==1? ("0" + hour):hour;
		var minute = regdate.getMinutes();
		minute = (minute + "").length==1? ("0" + minute):minute;
		returnValue = (hour + ":" + minute);
	} else {
		returnValue = (rMonth + "-" + rDate);
	}
	
	return returnValue;
}
function recommentToggle(num) {
	$("#recomment-list-" + num).toggle();
}
function mine(mem_num) {
	if(mem_num != '${sessionScope.num}') {
		return "off";
	}
}
</script>
<style>
.container-view {
	margin-top: 15px;
	border: 1px solid #D5D5D5;
	border-radius: 5px;
}
.container-view .view-subject {
	display: flex;
	padding: 10px;
	border-bottom: 1px solid #D5D5D5;
}
.container-view .view-subject .subject {
	flex-grow: 1;
}
.container-view .view-subject .other {
	display: flex;
	text-align: center;
}
.container-view .view-subject .other .username span {
	color: gray;
}
.container-view .view-subject .other .viewcnt {
	width: 50px;
}
.container-view .view-subject .other .regdate {
	width: 50px;
}
.container-view .view-content {
	padding: 10px;
}
.container-view .view-content .v-content {
	min-height: 500px;
}
.container-view .view-content .recommend {
	text-align: center;
}
.container-function {
	margin-top: 15px;
}
.container-function:after {
	content: "";
	display: block;
	clear: both;
}
.alert.alert-info.comment {
	display: none;
	opacity: 0;
}
.container-function .view-function {
	float: right;
}
#container-comment .empty-comment {
	padding: 30px;
	margin-bottom: 15px;
	text-align: center;
	border: 1px solid #D5D5D5;
	border-radius: 5px;
}
#container-comment .on {
	display: block;
}
#container-comment .off {
	display: none;
}
.rc-content-inner .btn-group.float-right {
	margin-bottom: 10px;
}
.container-comment-input {
	margin-top: 15px;
	margin-bottom: 15px;
	padding: 10px;
	border: 1px solid #D5D5D5;
	border-radius: 5px;
}
.container-comment-input.recomment {
	margin-bottom: 0;
	border-left: none;
	border-right: none;
	border-bottom: none;
	border-radius: 0;
	background-color: rgba(246, 246, 246, 0.4);
}
.container-comment-input .margin {
	margin-top: 5px;
}
.container-comment-input:after {
	content: "";
	display: block;
	clear: both;
}
.container-comment-title {
	margin-bottom: 5px;
}
.container-comment-title .popular-list, .new-list {
	cursor: pointer;
}
.container-comment-list {
	margin-bottom: 15px;
	border: 1px solid #D5D5D5;
	border-radius: 5px;
}
.container-comment-list .deleteComment {
	font-weight: bold;
	padding: 10px;
}
.container-comment-list .deleteReComment {
	display: flex;
	align-items: center;
	padding: 10px;
	font-weight: bold;
	border-left: 1px solid #D5D5D5;
}
.container-comment-list .comment-list {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
}
.container-comment-list .comment-list .comment-subject {
	display: flex;
	padding: 10px;
	border-bottom: 1px solid #D5D5D5;
}
.container-comment-list .comment-list .comment-subject .subject {
	flex-grow: 1;
}
.container-comment-list .comment-list .comment-subject .subject span {
	color: gray;
}
.container-comment-list .comment-list .comment-subject .regdate {
	width: 70px;
	text-align: center;
}
.container-comment-list .comment-list .comment-content {
	padding: 10px;
	padding-bottom: 0;
}
.container-comment-list .comment-list .comment-content .c-content {
}
.container-comment-list .comment-list .recommend {
	margin: 10px;
}
.container-comment-list .comment-list .recommend .comment-like {
	margin: 0 5px;
}
.recommend-img {
	width: 16px;
	height: 16px;
}
.container-comment-list .recomment-list {
	display: none;
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
}
.container-comment-list .recomment-list.onRecomment {
	display: block;
}
.container-comment-list .recomment-list .recomment-content {
	display: flex;
	box-sizing: border-box;
	border-top: 1px solid #D5D5D5;
	background-color: rgba(246, 246, 246, 0.4);
}
.container-comment-list .recomment-list .recomment-content .arrow {
	width: 45px;
	height: 40px;
	padding-left: 10px;
	margin-right: 10px;
}
.container-comment-list .recomment-list .recomment-content .arrow img {
	width: 100%;
	height: 100%;
}
.container-comment-list .recomment-list .recomment-content .rc-content {
	flex-grow: 1;
	border-left: 1px solid #D5D5D5;
}
.container-comment-list .recomment-list .recomment-content .rc-content .rc-subject {
	display: flex;
	padding: 10px;
	border-bottom: 1px solid #D5D5D5;
}
.container-comment-list .recomment-list .recomment-content .rc-content .rc-subject .subject {
	flex-grow: 1;
}
.container-comment-list .recomment-list .recomment-content .rc-content .rc-subject .subject span {
	color: gray;
}
.container-comment-list .recomment-list .recomment-content .rc-content .rc-subject .regdate {
	width: 70px;
	text-align: center;
}
.container-comment-list .recomment-list .recomment-content .rc-content .rc-content-inner {
	padding: 10px;
}
.container-comment-list .recomment-list .recomment-content .rc-content .rc-content-inner .rc-content-inner-content {
	margin-bottom: 5px;
}
@media (max-width:700px) {
	.view-subject .subject {
		text-overflow: ellipsis;
		overflow: hidden;
		white-space: nowrap;
	}
	.container-function .view-function {
		float: none;
		text-align: center;
	}
}
</style>
<div class="container-view">
	<div class="view-subject">
		<div class="subject">
			${dto.subject}
		</div>
		<div class="other">
			<div class="username">${dto.nickname}(<span>${dto.id}</span>)</div>
			<div class="viewcnt"><span class="badge badge-pill badge-info">${dto.viewcnt}</span></div>
			<div class="regdate" id="regdate">${dto.regdate}</div>
		</div>
	</div>
	<div class="view-content">
		<div class="v-content">
			${dto.content}
		</div>
		<div class="recommend">
			<button type="button" class="btn btn-primary" onclick="recommend(${empty dto.num? 0:dto.num}, ${empty sessionScope.num? 0:sessionScope.num}, 1);">
				좋아요 <span id="like-count" class="badge badge-light">${dto.like}</span>
			</button>
			<button type="button" class="btn btn-danger" onclick="recommend(${empty dto.num? 0:dto.num}, ${empty sessionScope.num? 0:sessionScope.num}, 2);">
				싫어요 <span id="hate-count" class="badge badge-light">${dto.hate}</span>
			</button>
		</div>
	</div>
</div>
<div class="container-function">
	<div class="view-function">
		<c:choose>
			<c:when test="${sessionScope.num == dto.mem_num}">
				<button type="button" class="btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/board/update?type=freeUpdate&num=${dto.num}'">수정하기</button>
				<button type="button" class="btn btn-outline-danger" onclick="deleteConfirm();">삭제하기</button>
			</c:when>
		</c:choose>
		<button type="button" class="btn btn-outline-secondary" onclick="list('${param.type}');">목록으로</button>
	</div>
</div>
<div class="container-comment-input">
  <textarea class="form-control" rows="5" id="comment" onkeyup="limitComment(this);" placeholder="내용을 입력해주세요."></textarea>
  (<span id="comment-limit" class="margin">0</span>/300)
  <button type="button" id="comment-write" class="btn btn-outline-primary float-right margin">작성하기</button>
</div>
  <div class="alert alert-info comment">
    <strong>안내</strong> 댓글은 10자 이상 300자 이하로 입력해주세요.
  </div>
<div class="container-comment-title">
	댓글 <span id="comment-count" class="badge badge-pill badge-primary">0</span> <span class="badge badge-light popular-list">공감순</span> <span class="badge badge-light new-list">최신순</span>
</div>
<div id="container-comment">
</div>
<div class="modal fade" id="myModal2">
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
			<form action="${pageContext.request.contextPath}/board/deleteOk" id="delete-form" method="post">
				<input type="hidden" name="type" value="freeDelete"/>
				<input type="hidden" name="num" value="${dto.num}"/>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
			<button type="button" id="delete-btn" class="btn btn-danger">확인</button>
			<button type="button" id='delete-btn-c' class="btn btn-secondary" data-dismiss="modal">취소</button>
		</div>
		</div>
	</div>
</div>
<input type="hidden" id="header" value="${_csrf.headerName}"/>
<input type="hidden" id="token" value="${_csrf.token}"/>

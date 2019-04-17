package com.web.ncm.board.domain;

import java.util.List;

public class CommentCountDTO {
	
	// 해당 게시글 댓글 고유번호 목록
	private List<CommentDTO> list;
	// 해당 게시글 댓글 수
	private int commentsCount;
	
	public List<CommentDTO> getList() {
		return list;
	}
	public void setList(List<CommentDTO> list) {
		this.list = list;
	}
	public int getCommentsCount() {
		return commentsCount;
	}
	public void setCommentsCount(int commentsCount) {
		this.commentsCount = commentsCount;
	}
	
}

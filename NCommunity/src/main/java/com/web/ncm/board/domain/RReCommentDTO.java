package com.web.ncm.board.domain;

import java.util.List;

public class RReCommentDTO {
	
	private List<ReCommentDTO> list;
	private int count;
	private String status;
	private CommentCountDTO commentCount;
	
	public RReCommentDTO() { }

	public RReCommentDTO(List<ReCommentDTO> list, int count, String status, CommentCountDTO commentCount) {
		this.list = list;
		this.count = count;
		this.status = status;
		this.commentCount = commentCount;
	}

	public List<ReCommentDTO> getList() {
		return list;
	}

	public void setList(List<ReCommentDTO> list) {
		this.list = list;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public CommentCountDTO getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(CommentCountDTO commentCount) {
		this.commentCount = commentCount;
	}
	
}

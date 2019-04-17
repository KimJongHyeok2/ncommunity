package com.web.ncm.board.domain;

import java.util.List;

public class RCommentDTO {
	
	private List<CommentDTO> list;
	private int count;
	private String status;
	
	public RCommentDTO() { }
	
	public RCommentDTO(List<CommentDTO> list, int count, String status) {
		this.list = list;
		this.count = count;
		this.status = status;
	}
	
	public List<CommentDTO> getList() {
		return list;
	}
	
	public void setList(List<CommentDTO> list) {
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
	
}

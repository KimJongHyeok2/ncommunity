package com.web.ncm.board.domain;

import java.sql.Timestamp;

public class CommentDTO {
	
	private int num;
	private int board_num;
	private int mem_num;
	private String content;
	private int like;
	private int hate;
	private int status;
	private Timestamp regdate;
	
	// 작성자 아이디
	private String id;
	// 작성자 닉네임
	private String nickname;
	// 댓글 타입
	private String type;
	
	public CommentDTO() { }

	public CommentDTO(int num, int board_num, int mem_num, String content, int like, int hate, int status,
			Timestamp regdate, String id, String nickname, String type) {
		this.num = num;
		this.board_num = board_num;
		this.mem_num = mem_num;
		this.content = content;
		this.like = like;
		this.hate = hate;
		this.status = status;
		this.regdate = regdate;
		this.id = id;
		this.nickname = nickname;
		this.type = type;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getBoard_num() {
		return board_num;
	}

	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getLike() {
		return like;
	}

	public void setLike(int like) {
		this.like = like;
	}

	public int getHate() {
		return hate;
	}

	public void setHate(int hate) {
		this.hate = hate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Timestamp getRegdate() {
		return regdate;
	}

	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
}

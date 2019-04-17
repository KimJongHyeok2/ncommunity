package com.web.ncm.board.domain;

import java.sql.Timestamp;

public class ReCommentDTO {
	
	private int num;
	private int comment_num;
	private int board_num;
	private int mem_num;
	private String content;
	private int status;
	private Timestamp regdate;
	
	// 작성자 아이디
	private String id;
	// 작성자 닉네임
	private String nickname;
	// 답글 타입
	private String type;
	
	public ReCommentDTO() { }

	public ReCommentDTO(int num, int comment_num, int board_num, int mem_num, String content, int status,
			Timestamp regdate, String id, String nickname, String type) {
		this.num = num;
		this.comment_num = comment_num;
		this.board_num = board_num;
		this.mem_num = mem_num;
		this.content = content;
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

	public int getComment_num() {
		return comment_num;
	}

	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
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

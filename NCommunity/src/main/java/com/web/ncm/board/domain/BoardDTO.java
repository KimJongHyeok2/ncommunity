package com.web.ncm.board.domain;

import java.sql.Timestamp;

public class BoardDTO {
	
	private int num;
	private int mem_num;
	private String subject;
	private String content;
	private int like;
	private int hate;
	private int status;
	private int viewcnt;
	private Timestamp regdate;
	
	// 글 타입
	private String type;
	// 작성자 닉네임
	private String nickname;
	
	public BoardDTO() { }

	public BoardDTO(int num, int mem_num, String subject, String content, int like, int hate, int status, int viewcnt,
			Timestamp regdate, String type, String nickname) {
		this.num = num;
		this.mem_num = mem_num;
		this.subject = subject;
		this.content = content;
		this.like = like;
		this.hate = hate;
		this.status = status;
		this.viewcnt = viewcnt;
		this.regdate = regdate;
		this.type = type;
		this.nickname = nickname;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
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

	public int getViewcnt() {
		return viewcnt;
	}

	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}

	public Timestamp getRegdate() {
		return regdate;
	}

	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
}

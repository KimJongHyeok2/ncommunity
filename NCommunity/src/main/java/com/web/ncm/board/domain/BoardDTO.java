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
	// 작성자 아이디
	private String id;
	// 작성자 닉네임
	private String nickname;
	// 작성자  프로필 사진
	private String profile;
	// 게시물 총 댓글 수
	private int commentsCount;
	// 비디오 타입 글 Thumbnail Key
	private String thumb;
	// 비디오 타입 글 설명
	private String description;
	// 게시물 인기순위
	private int rnum;
	
	public BoardDTO() { }

	public BoardDTO(int num, int mem_num, String subject, String content, int like, int hate, int status, int viewcnt,
			Timestamp regdate, String type, String id, String nickname, String profile, int commentsCount, String thumb,
			String description, int rnum) {
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
		this.id = id;
		this.nickname = nickname;
		this.profile = profile;
		this.commentsCount = commentsCount;
		this.thumb = thumb;
		this.description = description;
		this.rnum = rnum;
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

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public int getCommentsCount() {
		return commentsCount;
	}

	public void setCommentsCount(int commentsCount) {
		this.commentsCount = commentsCount;
	}

	public String getThumb() {
		return thumb;
	}

	public void setThumb(String thumb) {
		this.thumb = thumb;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	
}

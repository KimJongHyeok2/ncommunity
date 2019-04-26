package com.web.ncm.domain;

import java.security.MessageDigest;
import java.sql.Date;
import java.sql.Timestamp;

public class MemberDTO {

	private int mem_num;
	private String mem_id;
	private String mem_pw;
	private String mem_profile;
	private String mem_nickname;
	private Date mem_birth;
	private String mem_email;
	private String mem_auth;
	private int enabled;
	private Timestamp mem_regdate;
	
	public MemberDTO() { }
	
	public MemberDTO(int mem_num, String mem_id, String mem_pw, String mem_profile, String mem_nickname, Date mem_birth,
			String mem_email, String mem_auth, int enabled, Timestamp mem_regdate) {
		this.mem_num = mem_num;
		this.mem_id = mem_id;
		this.mem_pw = mem_pw;
		this.mem_profile = mem_profile;
		this.mem_nickname = mem_nickname;
		this.mem_birth = mem_birth;
		this.mem_email = mem_email;
		this.mem_auth = mem_auth;
		this.enabled = enabled;
		this.mem_regdate = mem_regdate;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getMem_pw() {
		return mem_pw;
	}

	public void setMem_pw(String mem_pw) {
		// 비밀번호 SHA256 암호화
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(mem_pw.getBytes());
			byte byteData[] = md.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			StringBuffer hexString = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				String hex = Integer.toHexString(0xff & byteData[i]);
				if (hex.length() == 1) {
					hexString.append('0');
				}
				hexString.append(hex);
			}
			this.mem_pw = hexString.toString();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
	}

	public String getMem_profile() {
		return mem_profile;
	}

	public void setMem_profile(String mem_profile) {
		this.mem_profile = mem_profile;
	}

	public String getMem_nickname() {
		return mem_nickname;
	}

	public void setMem_nickname(String mem_nickname) {
		this.mem_nickname = mem_nickname;
	}

	public Date getMem_birth() {
		return mem_birth;
	}

	public void setMem_birth(Date mem_birth) {
		this.mem_birth = mem_birth;
	}

	public String getMem_email() {
		return mem_email;
	}

	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}

	public String getMem_auth() {
		return mem_auth;
	}

	public void setMem_auth(String mem_auth) {
		this.mem_auth = mem_auth;
	}

	public int getEnabled() {
		return enabled;
	}

	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}

	public Timestamp getMem_regdate() {
		return mem_regdate;
	}

	public void setMem_regdate(Timestamp mem_regdate) {
		this.mem_regdate = mem_regdate;
	}
	
}

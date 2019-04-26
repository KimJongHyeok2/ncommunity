package com.web.ncm.domain;

import java.security.MessageDigest;

public class JoinDTO {

	private String mem_id;
	private String mem_pw;
	private String mem_birth;
	private String mem_email;
	
	public JoinDTO() { }
	
	public JoinDTO(String mem_id, String mem_pw, String mem_birth, String mem_email) {
		this.mem_id = mem_id;
		this.mem_pw = mem_pw;
		this.mem_birth = mem_birth;
		this.mem_email = mem_email;
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
	
	public String getMem_birth() {
		return mem_birth;
	}
	
	public void setMem_birth(String mem_birth) {
		this.mem_birth = mem_birth;
	}
	
	public String getMem_email() {
		return mem_email;
	}
	
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}

	@Override
	public String toString() {
		return "JoinDTO [mem_id=" + mem_id + ", mem_pw=" + mem_pw + ", mem_birth=" + mem_birth + ", mem_email="
				+ mem_email + "]";
	}
	
}

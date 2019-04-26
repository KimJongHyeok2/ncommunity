package com.web.ncm.domain;

import java.util.Random;

public class EmailAccessDTO {
	
	private int ekey_num;
	private String ekey_accesskey;
	private boolean lowerCheck = false;
	private int size = 20;
	
	public EmailAccessDTO() {
		initKey();
	}

	public int getEkey_num() {
		return ekey_num;
	}

	public void setEkey_num(int ekey_num) {
		this.ekey_num = ekey_num;
	}

	public String getEkey_accesskey() {
		return ekey_accesskey;
	}

	public void setEkey_accesskey(String ekey_accesskey) {
		this.ekey_accesskey = ekey_accesskey;
	}

	public boolean isLowerCheck() {
		return lowerCheck;
	}

	public void setLowerCheck(boolean lowerCheck) {
		this.lowerCheck = lowerCheck;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	// 이메일 인증키 생성
	private void initKey() {
		Random ran = new Random();
		StringBuffer sb = new StringBuffer();
		int num = 0;

		do {
			num = ran.nextInt(75) + 48;
			if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
				sb.append((char) num);
			} else {
				continue;
			}

		} while (sb.length() < size);
		if (lowerCheck) {
			this.ekey_accesskey = sb.toString().toLowerCase();
		}
		this.ekey_accesskey = sb.toString(); 
	}
	
}

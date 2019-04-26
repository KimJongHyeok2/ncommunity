package com.web.ncm.domain;

public class ImageUploadDTO {
	
	private boolean uploaded;
	private String url;
	
	public ImageUploadDTO() { }
	
	public ImageUploadDTO(boolean uploaded, String url) {
		this.uploaded = uploaded;
		this.url = url;
	}
	
	public boolean isUploaded() {
		return uploaded;
	}
	
	public void setUploaded(boolean uploaded) {
		this.uploaded = uploaded;
	}
	
	public String getUrl() {
		return url;
	}
	
	public void setUrl(String url) {
		this.url = url;
	}
	
}

package com.web.ncm.domain;

public class PaginationDTO {

	private int pageBlock;
	private int pageCount;
	private int startPage;
	private int endPage;
	
	public PaginationDTO() { }
	
	public PaginationDTO(int pageBlock, int pageCount, int startPage, int endPage) {
		this.pageBlock = pageBlock;
		this.pageCount = pageCount;
		this.startPage = startPage;
		this.endPage = endPage;
	}
	
	public int getPageBlock() {
		return pageBlock;
	}
	
	public void setPageBlock(int pageBlock) {
		this.pageBlock = pageBlock;
	}
	
	public int getPageCount() {
		return pageCount;
	}
	
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	
	public int getStartPage() {
		return startPage;
	}
	
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	
	public int getEndPage() {
		return endPage;
	}
	
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
}

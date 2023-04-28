package com.kpms.prj.vo;

import com.kpms.common.vo.AbstractPagingVO;

public class PrjSearchVO extends AbstractPagingVO {
	
	private String prjNm;
	private String cstmr;
	private String prjStts;
	
	private String searchOption;
	private String searchKeyword;
	
	
	public String getPrjStts() {
		return prjStts;
	}
	public void setPrjStts(String prjStts) {
		this.prjStts = prjStts;
	}
	public String getPrjNm() {
		return prjNm;
	}
	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}
	public String getCstmr() {
		return cstmr;
	}
	public void setCstmr(String cstmr) {
		this.cstmr = cstmr;
	}
	public String getSearchOption() {
		return searchOption;
	}
	public void setSearchOption(String searchOption) {
		this.searchOption = searchOption;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	

}

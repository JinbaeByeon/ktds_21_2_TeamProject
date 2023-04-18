package com.kpms.tm.vo;

import com.kpms.common.vo.AbstractPagingVO;

public class TmSearchVO extends AbstractPagingVO {
	private String tmNm;
	private String fNm;
	private String lNm;
	
	public String getTmNm() {
		return tmNm;
	}
	public void setTmNm(String tmNm) {
		this.tmNm = tmNm;
	}
	public String getfNm() {
		return fNm;
	}
	public void setfNm(String fNm) {
		this.fNm = fNm;
	}
	public String getlNm() {
		return lNm;
	}
	public void setlNm(String lNm) {
		this.lNm = lNm;
	}
	
}

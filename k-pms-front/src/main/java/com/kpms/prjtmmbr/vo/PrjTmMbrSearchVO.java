package com.kpms.prjtmmbr.vo;

import com.kpms.common.vo.AbstractPagingVO;

public class PrjTmMbrSearchVO extends AbstractPagingVO {
	
	private String prjId;
	private String empId;
	private String nm;
	private String fNm;
	private String lNm;
	
	private String searchOption;
	private String searchKeyword;
	
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getNm() {
		return nm;
	}
	public void setNm(String nm) {
		if (nm != null) {
			this.nm = nm.replace(" ", "");
		}
	}
	public String getPrjId() {
		return prjId;
	}
	public void setPrjId(String prjId) {
		this.prjId = prjId;
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

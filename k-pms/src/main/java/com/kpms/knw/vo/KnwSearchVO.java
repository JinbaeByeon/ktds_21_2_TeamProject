package com.kpms.knw.vo;

import com.kpms.common.vo.AbstractPagingVO;

public class KnwSearchVO extends AbstractPagingVO {

	private String searchOption;
	private String searchKeyword;
	private boolean commonMode;
	private String empId;
	private String prjId;
	private String admnYn;

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

	public boolean isCommonMode() {
		return commonMode;
	}

	public void setCommonMode(boolean commonMode) {
		this.commonMode = commonMode;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getPrjId() {
		return prjId;
	}

	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}

	public String getAdmnYn() {
		return admnYn;
	}

	public void setAdmnYn(String admnYn) {
		this.admnYn = admnYn;
	}

}

package com.kpms.rcvmsg.vo;

import com.kpms.common.vo.AbstractPagingVO;

public class MsgSearchVO extends AbstractPagingVO {

	private String empId;
	private String searchType;
	private String searchKeyword;

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

}

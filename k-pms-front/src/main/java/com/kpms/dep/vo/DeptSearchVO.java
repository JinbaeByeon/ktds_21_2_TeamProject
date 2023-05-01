package com.kpms.dep.vo;

import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.tm.vo.TmSearchVO;

public class DeptSearchVO extends AbstractPagingVO {

	private String depNm;
	private String fNm;
	private String lNm;
	
	private String empId;
	
	private String searchOption;
	private String searchKeyword;
	
	private TmSearchVO tmSearchVO;

	
	
	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getDepNm() {
		return depNm;
	}

	public void setDepNm(String depNm) {
		this.depNm = depNm;
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

	public TmSearchVO getTmSearchVO() {
		return tmSearchVO;
	}

	public void setTmSearchVO(TmSearchVO tmSearchVO) {
		this.tmSearchVO = tmSearchVO;
	}
	
}

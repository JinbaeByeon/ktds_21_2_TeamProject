package com.kpms.tm.vo;

import com.kpms.common.vo.AbstractPagingVO;

public class TmSearchVO extends AbstractPagingVO {
	private String tmNm;

	private String searchOption;
	private String searchKeyword;

	public String getTmNm() {
		return tmNm;
	}

	public void setTmNm(String tmNm) {
		this.tmNm = tmNm;
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

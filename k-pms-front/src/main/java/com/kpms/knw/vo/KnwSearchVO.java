package com.kpms.knw.vo;

import com.kpms.common.vo.AbstractPagingVO;

public class KnwSearchVO extends AbstractPagingVO {

	private String searchOption;
	private String searchKeyword;

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

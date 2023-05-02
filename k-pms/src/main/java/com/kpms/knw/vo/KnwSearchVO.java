package com.kpms.knw.vo;

import com.kpms.common.vo.AbstractPagingVO;

public class KnwSearchVO extends AbstractPagingVO {

	private String searchOption;
	private String searchKeyword;
	private String commonMode;
	private String prjId;

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

	public String getPrjId() {
		return prjId;
	}

	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}

	public String getCommonMode() {
		return commonMode;
	}

	public void setCommonMode(String commonMode) {
		this.commonMode = commonMode;
	}

}

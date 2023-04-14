package com.kpms.dep.vo;

import com.kpms.common.vo.AbstractPagingVO;

public class DeptSearchVO extends AbstractPagingVO {

	private String depNm;
	private String tmNm;

	public String getDepNm() {
		return depNm;
	}

	public void setDepNm(String depNm) {
		this.depNm = depNm;
	}

	public String getTmNm() {
		return tmNm;
	}

	public void setTmNm(String tmNm) {
		this.tmNm = tmNm;
	}

}

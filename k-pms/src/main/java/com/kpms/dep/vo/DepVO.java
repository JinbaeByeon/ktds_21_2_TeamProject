package com.kpms.dep.vo;

import com.kpms.common.vo.AbstractVO;

/**
 * DEP
 */
public class DepVO extends AbstractVO {

	private String depId;
	private String depHdNm;
	private String depHdId;
	private String depCrtDt;
	
	
	public String getDepId() {
		return depId;
	}
	public void setDepId(String depId) {
		this.depId = depId;
	}
	
	public String getDepHdNm() {
		return depHdNm;
	}
	public void setDepHdNm(String depHdNm) {
		this.depHdNm = depHdNm;
	}
	public String getDepHdId() {
		return depHdId;
	}
	public void setDepHdId(String depHdId) {
		this.depHdId = depHdId;
	}
	public String getDepCrtDt() {
		return depCrtDt;
	}
	public void setDepCrtDt(String depCrtDt) {
		this.depCrtDt = depCrtDt;
	}
	
	
}
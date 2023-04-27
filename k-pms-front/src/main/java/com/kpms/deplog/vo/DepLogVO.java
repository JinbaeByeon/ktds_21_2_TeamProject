package com.kpms.deplog.vo;

import com.kpms.common.vo.AbstractVO;

/**
 * DEP_LOG
 */
public class DepLogVO extends AbstractVO {
	private String empId;
	private String chngDt;
	private String prvsDepId;
	private String chngDepId;
	private String chngRsn;


	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getEmpId() {
		return this.empId;
	}

	public void setChngDt(String chngDt) {
		this.chngDt = chngDt;
	}

	public String getChngDt() {
		return this.chngDt;
	}

	public void setPrvsDepId(String prvsDepId) {
		this.prvsDepId = prvsDepId;
	}

	public String getPrvsDepId() {
		return this.prvsDepId;
	}

	public void setChngDepId(String chngDepId) {
		this.chngDepId = chngDepId;
	}

	public String getChngDepId() {
		return this.chngDepId;
	}

	public void setChngRsn(String chngRsn) {
		this.chngRsn = chngRsn;
	}

	public String getChngRsn() {
		return this.chngRsn;
	}

}
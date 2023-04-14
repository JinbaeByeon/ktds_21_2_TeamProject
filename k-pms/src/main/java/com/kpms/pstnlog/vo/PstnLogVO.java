package com.kpms.pstnlog.vo;

import com.kpms.common.vo.AbstractPagingVO;

/**
 * PSTN_LOG
 */
public class PstnLogVO extends AbstractPagingVO {

	private String empId;
	private String chngDt;
	private String prvsPstnId;
	private String chngPstnId;
	private String chngRsn;
	
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getChngDt() {
		return chngDt;
	}
	public void setChngDt(String chngDt) {
		this.chngDt = chngDt;
	}
	public String getPrvsPstnId() {
		return prvsPstnId;
	}
	public void setPrvsPstnId(String prvsPstnId) {
		this.prvsPstnId = prvsPstnId;
	}
	public String getChngPstnId() {
		return chngPstnId;
	}
	public void setChngPstnId(String chngPstnId) {
		this.chngPstnId = chngPstnId;
	}
	public String getChngRsn() {
		return chngRsn;
	}
	public void setChngRsn(String chngRsn) {
		this.chngRsn = chngRsn;
	}

}
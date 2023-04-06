package com.kpms.joblog.vo;

/**
 * JOB_LOG
 */
public class JobLogVO {

	private String empId;
	private String chngDt;
	private String prvsJobId;
	private String chngJobId;
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

	public String getPrvsJobId() {
		return prvsJobId;
	}

	public void setPrvsJobId(String prvsJobId) {
		this.prvsJobId = prvsJobId;
	}

	public String getChngJobId() {
		return chngJobId;
	}

	public void setChngJobId(String chngJobId) {
		this.chngJobId = chngJobId;
	}

	public String getChngRsn() {
		return chngRsn;
	}

	public void setChngRsn(String chngRsn) {
		this.chngRsn = chngRsn;
	}

}
package com.kpms.emp.vo;

import java.util.List;

public class EmpChngJobVO {
	private List<String> empIdList;
	private int jobId;
	private String mdfyr;
	private String chngRsn;

	public List<String> getEmpIdList() {
		return empIdList;
	}
	public void setEmpIdList(List<String> empIdList) {
		this.empIdList = empIdList;
	}
	public int getJobId() {
		return jobId;
	}
	public void setJobId(int jobId) {
		this.jobId = jobId;
	}
	public String getMdfyr() {
		return mdfyr;
	}
	public void setMdfyr(String mdfyr) {
		this.mdfyr = mdfyr;
	}
	public String getChngRsn() {
		return chngRsn;
	}
	public void setChngRsn(String chngRsn) {
		this.chngRsn = chngRsn;
	}
	
}

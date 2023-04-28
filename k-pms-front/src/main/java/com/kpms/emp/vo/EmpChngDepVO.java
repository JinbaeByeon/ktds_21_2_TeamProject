package com.kpms.emp.vo;

import java.util.List;

public class EmpChngDepVO {
	private List<String> empIdList;
	private String depId;
	private String mdfyr;
	private String chngRsn;

	public List<String> getEmpIdList() {
		return empIdList;
	}
	public void setEmpIdList(List<String> empIdList) {
		this.empIdList = empIdList;
	}
	public String getDepId() {
		return depId;
	}
	public void setDepId(String depId) {
		this.depId = depId;
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

package com.kpms.emp.vo;

import java.util.List;

public class EmpChngEmplmntVO {
	private List<String> empIdList;
	private String emplmntStts;
	private String mdfyr;

	public List<String> getEmpIdList() {
		return empIdList;
	}
	public void setEmpIdList(List<String> empIdList) {
		this.empIdList = empIdList;
	}
	public String getEmplmntStts() {
		return emplmntStts;
	}
	public void setEmplmntStts(String emplmntStts) {
		this.emplmntStts = emplmntStts;
	}
	public String getMdfyr() {
		return mdfyr;
	}
	public void setMdfyr(String mdfyr) {
		this.mdfyr = mdfyr;
	}
	
}

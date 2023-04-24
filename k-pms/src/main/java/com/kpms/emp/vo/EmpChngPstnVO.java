package com.kpms.emp.vo;

import java.util.List;

public class EmpChngPstnVO {
	private List<String> empIdList;
	private int pstnId;
	private String mdfyr;
	private String chngRsn;
	
	public List<String> getEmpIdList() {
		return empIdList;
	}
	public void setEmpIdList(List<String> empIdList) {
		this.empIdList = empIdList;
	}
	public int getPstnId() {
		return pstnId;
	}
	public void setPstnId(int pstnId) {
		this.pstnId = pstnId;
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

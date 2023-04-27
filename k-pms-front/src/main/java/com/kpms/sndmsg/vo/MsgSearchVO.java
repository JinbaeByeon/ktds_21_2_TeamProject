package com.kpms.sndmsg.vo;

import com.kpms.common.vo.AbstractPagingVO;

public class MsgSearchVO extends AbstractPagingVO{

	private String empId;
	private String nm;
	private String fNm;
	private String lNm;
	
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	
	public String getNm() {
		return nm;
	}
	public void setNm(String nm) {
		if (nm != null) {
			this.nm = nm.replace(" ", "");
		}
	}
	public String getfNm() {
		return fNm;
	}
	public void setfNm(String fNm) {
		this.fNm = fNm;
	}
	public String getlNm() {
		return lNm;
	}
	public void setlNm(String lNm) {
		this.lNm = lNm;
	}
	
}

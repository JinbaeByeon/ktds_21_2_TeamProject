package com.kpms.rcvmsg.vo;

import com.kpms.common.vo.AbstractPagingVO;

public class MsgSearchVO extends AbstractPagingVO{

	private String empId;
	private String fNm;
	
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getfNm() {
		return fNm;
	}
	public void setfNm(String fNm) {
		this.fNm = fNm;
	}
	
}

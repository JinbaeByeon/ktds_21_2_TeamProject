package com.kpms.reqtstr.vo;

import com.kpms.common.vo.AbstractVO;
import com.kpms.emp.vo.EmpVO;

/**
 * REQ_TSTR
 */
public class ReqTstrVO extends AbstractVO {

	private String tstrId;
	private String reqId;
	private EmpVO tstrEmpVO;
	
	
	public EmpVO getTstrEmpVO() {
		return tstrEmpVO;
	}
	public void setTstrEmpVO(EmpVO tstrEmpVO) {
		this.tstrEmpVO = tstrEmpVO;
	}
	public String getTstrId() {
		return tstrId;
	}
	public void setTstrId(String tstrId) {
		this.tstrId = tstrId;
	}
	public String getReqId() {
		return reqId;
	}
	public void setReqId(String reqId) {
		this.reqId = reqId;
	}

}
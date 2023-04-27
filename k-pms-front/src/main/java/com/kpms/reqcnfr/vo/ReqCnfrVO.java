package com.kpms.reqcnfr.vo;

import com.kpms.common.vo.AbstractVO;

/**
 * REQ_CNFR
 */
public class ReqCnfrVO extends AbstractVO {

	private String cnfrId;
	private String rqrId;
	
	public String getCnfrId() {
		return cnfrId;
	}
	public void setCnfrId(String cnfrId) {
		this.cnfrId = cnfrId;
	}
	public String getRqrId() {
		return rqrId;
	}
	public void setRqrId(String rqrId) {
		this.rqrId = rqrId;
	}

}
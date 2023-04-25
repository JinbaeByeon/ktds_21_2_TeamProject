package com.kpms.reqcnfr.vo;

import com.kpms.common.vo.AbstractVO;

/**
 * REQ_CNFR
 */
public class ReqCnfrVO extends AbstractVO {

	private String cnfrId;
	private String cnfrNm;
	private String reqId;
	
	
	public String getCnfrNm() {
		return cnfrNm;
	}
	public void setCnfrNm(String cnfrNm) {
		this.cnfrNm = cnfrNm;
	}
	public String getCnfrId() {
		return cnfrId;
	}
	public void setCnfrId(String cnfrId) {
		this.cnfrId = cnfrId;
	}
	public String getReqId() {
		return reqId;
	}
	public void setReqId(String reqId) {
		this.reqId = reqId;
	}

}
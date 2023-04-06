package com.kpms.reqtstr.vo;

import com.kpms.common.vo.AbstractVO;

/**
 * REQ_TSTR
 */
public class ReqTstrVO extends AbstractVO {

	private String tstrId;
	private String rqrId;
	
	public String getTstrId() {
		return tstrId;
	}
	public void setTstrId(String tstrId) {
		this.tstrId = tstrId;
	}
	public String getRqrId() {
		return rqrId;
	}
	public void setRqrId(String rqrId) {
		this.rqrId = rqrId;
	}

}
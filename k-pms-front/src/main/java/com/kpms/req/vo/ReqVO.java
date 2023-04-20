package com.kpms.req.vo;

import com.kpms.common.vo.AbstractVO;

/**
 * REQ
 */
public class ReqVO extends AbstractVO {

	private String reqId;
	private String dtlReq;
	private String strtDt;
	private String expctEndDt;
	private String attch;
	private String prjId;
	private String mnDvlpr;
	private String tstRslt;
	private String tskStts;
	private String prcsStts;
	private String prrty;
	private String reqTtl;

	public String getReqId() {
		return reqId;
	}
	public void setReqId(String reqId) {
		this.reqId = reqId;
	}
	public String getReqTtl() {
		return reqTtl;
	}
	public void setReqTtl(String reqTtl) {
		this.reqTtl = reqTtl;
	}
	public String getDtlReq() {
		return dtlReq;
	}
	public void setDtlReq(String dtlReq) {
		this.dtlReq = dtlReq;
	}
	public String getStrtDt() {
		return strtDt;
	}
	public void setStrtDt(String strtDt) {
		this.strtDt = strtDt;
	}
	public String getExpctEndDt() {
		return expctEndDt;
	}
	public void setExpctEndDt(String expctEndDt) {
		this.expctEndDt = expctEndDt;
	}
	public String getAttch() {
		return attch;
	}
	public void setAttch(String attch) {
		this.attch = attch;
	}
	public String getPrjId() {
		return prjId;
	}
	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}
	public String getMnDvlpr() {
		return mnDvlpr;
	}
	public void setMnDvlpr(String mnDvlpr) {
		this.mnDvlpr = mnDvlpr;
	}
	public String getTstRslt() {
		return tstRslt;
	}
	public void setTstRslt(String tstRslt) {
		this.tstRslt = tstRslt;
	}
	public String getTskStts() {
		return tskStts;
	}
	public void setTskStts(String tskStts) {
		this.tskStts = tskStts;
	}
	public String getPrcsStts() {
		return prcsStts;
	}
	public void setPrcsStts(String prcsStts) {
		this.prcsStts = prcsStts;
	}
	public String getPrrty() {
		return prrty;
	}
	public void setPrrty(String prrty) {
		this.prrty = prrty;
	}

}
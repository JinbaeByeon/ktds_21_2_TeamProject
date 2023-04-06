package com.kpms.rcvmsg.vo;

/**
 * RCV_MSG
 */
public class RcvMsgVO {

	private String msgId;
	private String sndMsgId;
	private String rcvr;
	private String rdYn;
	
	public String getMsgId() {
		return msgId;
	}
	public void setMsgId(String msgId) {
		this.msgId = msgId;
	}
	public String getSndMsgId() {
		return sndMsgId;
	}
	public void setSndMsgId(String sndMsgId) {
		this.sndMsgId = sndMsgId;
	}
	public String getRcvr() {
		return rcvr;
	}
	public void setRcvr(String rcvr) {
		this.rcvr = rcvr;
	}
	public String getRdYn() {
		return rdYn;
	}
	public void setRdYn(String rdYn) {
		this.rdYn = rdYn;
	}



}
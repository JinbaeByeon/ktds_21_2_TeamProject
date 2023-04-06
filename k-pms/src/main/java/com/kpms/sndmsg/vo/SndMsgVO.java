package com.kpms.sndmsg.vo;

import com.kpms.common.vo.AbstractVO;

/**
 * SND_MSG
 */
public class SndMsgVO extends AbstractVO {

	private String msgId;
	private String ttl;
	private String cntnt;
	private String attch;
	
	public String getMsgId() {
		return msgId;
	}
	public void setMsgId(String msgId) {
		this.msgId = msgId;
	}
	public String getTtl() {
		return ttl;
	}
	public void setTtl(String ttl) {
		this.ttl = ttl;
	}
	public String getCntnt() {
		return cntnt;
	}
	public void setCntnt(String cntnt) {
		this.cntnt = cntnt;
	}
	public String getAttch() {
		return attch;
	}
	public void setAttch(String attch) {
		this.attch = attch;
	}

}
package com.kpms.sndmsg.vo;

import java.util.List;

import com.kpms.common.vo.AbstractVO;
import com.kpms.emp.vo.EmpVO;
import com.kpms.rcvmsg.vo.RcvMsgVO;

/**
 * SND_MSG
 */
public class SndMsgVO extends AbstractVO {

	private String msgId;
	private String ttl;
	private String cntnt;
	private String attch;
	
	private List<RcvMsgVO> rcvMsgVO;
	private EmpVO sndEmpVO;
	
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
	public List<RcvMsgVO> getRcvMsgVO() {
		return rcvMsgVO;
	}
	public void setRcvMsgVO(List<RcvMsgVO> rcvMsgVO) {
		this.rcvMsgVO = rcvMsgVO;
	}
	public EmpVO getSndEmpVO() {
		return sndEmpVO;
	}
	public void setSndEmpVO(EmpVO sndEmpVO) {
		this.sndEmpVO = sndEmpVO;
	}

}
package com.kpms.rcvmsg.vo;

import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.emp.vo.EmpVO;
import com.kpms.sndmsg.vo.SndMsgVO;

/**
 * RCV_MSG
 */
public class RcvMsgVO extends AbstractPagingVO {

	private String msgId;
	private String sndMsgId;
	private String rcvr;
	private String rdYn;
	
	private SndMsgVO sndMsgVO;
	private EmpVO rcvrEmpVO;
	
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
	public SndMsgVO getSndMsgVO() {
		return sndMsgVO;
	}
	public void setSndMsgVO(SndMsgVO sndMsgVO) {
		this.sndMsgVO = sndMsgVO;
	}
	public EmpVO getRcvrEmpVO() {
		return rcvrEmpVO;
	}
	public void setRcvrEmpVO(EmpVO rcvrEmpVO) {
		this.rcvrEmpVO = rcvrEmpVO;
	}

}
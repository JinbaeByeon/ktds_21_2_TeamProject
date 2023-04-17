package com.kpms.rcvmsg.dao;

import java.util.List;

import com.kpms.rcvmsg.vo.RcvMsgVO;

public interface RcvMsgDAO {
	
	public List<RcvMsgVO>readAllRcvMsgVO(RcvMsgVO rcvMsgVO);
	
	public int createOneRcvMsg(RcvMsgVO rcvMsgVO);
	
	public int deleteOneRcvMsg(String msgId);
	
	public int deleteRcvMsgBySelectedMsgId(List<Integer> msgId);

}

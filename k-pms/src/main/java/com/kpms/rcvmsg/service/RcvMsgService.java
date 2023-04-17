package com.kpms.rcvmsg.service;

import java.util.List;

import com.kpms.rcvmsg.vo.RcvMsgVO;

public interface RcvMsgService {
	
	public List<RcvMsgVO>readAllRcvMsgVO(RcvMsgVO rcvMsgVO);
	
	public boolean createOneRcvMsg(RcvMsgVO rcvMsgVO);
	
	public boolean deleteOneRcvMsg(String msgId);
	
	public boolean deleteRcvMsgBySelectedMsgId(List<Integer> msgId);

}

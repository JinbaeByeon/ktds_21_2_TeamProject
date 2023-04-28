package com.kpms.rcvmsg.service;

import java.util.List;

import com.kpms.rcvmsg.vo.MsgSearchVO;
import com.kpms.rcvmsg.vo.MsgVOList;
import com.kpms.rcvmsg.vo.RcvMsgVO;

public interface RcvMsgService {
	
	public List<RcvMsgVO>readAllRcvMsgVO(MsgSearchVO rcvMsgVO);
	
	public boolean createOneRcvMsg(RcvMsgVO rcvMsgVO);
	
	public boolean deleteOneRcvMsg(String msgId);
	
	public boolean deleteRcvMsgBySelectedMsgId(List<String> msgId);

	public boolean updateRcvMsgReadByRcvMsgIdList(List<String> rcvMsgIdList);

	public boolean deleteTrashMsg(MsgVOList msgVOList);
	
	public RcvMsgVO readOneRcvMsg(String msgId);

	public List<RcvMsgVO> readAllDelMsg(MsgSearchVO msgSearchVO);
	
	public boolean restoreRcvMsg(MsgVOList msgVOList);
}

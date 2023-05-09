package com.kpms.rcvmsg.dao;

import java.util.List;

import com.kpms.rcvmsg.vo.MsgSearchVO;
import com.kpms.rcvmsg.vo.RcvMsgVO;
import com.kpms.sndmsg.vo.SndMsgVO;

public interface RcvMsgDAO {
	
	public List<RcvMsgVO> readAllRcvMsgVO(MsgSearchVO rcvMsgVO);
	public SndMsgVO readOneSndMsgVO(String rcvmsgId);
	public int readCntUnReadSndMsg(String empId);
	
	public int createOneRcvMsg(RcvMsgVO rcvMsgVO);
	public int createRcvMsg(SndMsgVO sndMsgVO);
	
	public int deleteOneRcvMsg(String msgId);
	
	public int deleteRcvMsgBySelectedMsgId(List<String> msgId);

	public int updateRcvMsgReadByRcvMsgIdList(List<String> rcvMsgIdList);
	public int updateRcvMsgReadByMsgId(String msgId);

	public int deleteTrashMsg(List<String> rcvMsgIdList);
	
	public RcvMsgVO readOneRcvMsg(String msgId);
	
	public List<RcvMsgVO> readAllDelMsg(MsgSearchVO msgSearchVO);
	
	public int restoreRcvMsg(List<String> rcvMsgIdList);

}

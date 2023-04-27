package com.kpms.sndmsg.service;

import java.util.List;

import com.kpms.rcvmsg.vo.MsgSearchVO;
import com.kpms.sndmsg.vo.SndMsgVO;

public interface SndMsgService {
	
	public List<SndMsgVO>readAllSndMsgVO(MsgSearchVO msgSearchVO);
	
	public boolean createOneSndMsg(SndMsgVO sndMsgVO);
	
	public boolean deleteOneSndMsg(String msgId);
	
	public boolean deleteSndMsgBySelectedMsgId(List<String> msgId);
	
	public SndMsgVO readOneSndMsgByRcvMsgId(String msgId);

	public SndMsgVO readOneSndMsgByMsgId(String msgId);
	
}

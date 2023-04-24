package com.kpms.sndmsg.dao;

import java.util.List;

import com.kpms.rcvmsg.vo.MsgSearchVO;
import com.kpms.sndmsg.vo.SndMsgVO;

public interface SndMsgDAO {
	
	public List<SndMsgVO>readAllSndMsgVO(MsgSearchVO msgSearchVO);
	
	public int createOneSndMsg(SndMsgVO sndMsgVO);
	
	public int deleteOneSndMsg(String msgId);
	
	public int deleteSndMsgBySelectedMsgId(List<String> msgId);

}

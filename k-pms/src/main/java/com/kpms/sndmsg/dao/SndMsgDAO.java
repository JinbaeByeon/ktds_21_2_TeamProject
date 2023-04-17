package com.kpms.sndmsg.dao;

import java.util.List;

import com.kpms.sndmsg.vo.SndMsgVO;

public interface SndMsgDAO {
	
	public List<SndMsgVO>readAllSndMsgVO(SndMsgVO sndMsgVO);
	
	public int createOneSndMsg(SndMsgVO sndMsgVO);
	
	public int updateOneSndMsg(SndMsgVO sndMsgVO);
	
	public int deleteOneSndMsg(int msgId);
	
	public int deleteSndMsgBySelectedMsgId(List<Integer> msgId);

}

package com.kpms.sndmsg.service;

import java.util.List;

import com.kpms.sndmsg.vo.SndMsgVO;

public interface SndMsgService {
	
	public List<SndMsgVO>readAllSndMsgVO(SndMsgVO sndMsgVO);
	
	public boolean createOneSndMsg(SndMsgVO sndMsgVO);
	
	public boolean updateOneSndMsg(SndMsgVO sndMsgVO);
	
	public boolean deleteOneSndMsg(String msgId);
	
	public boolean deleteSndMsgBySelectedMsgId(List<String> msgId);
	
	public SndMsgVO readOneSndMsgByRcvMsgId(String msgId);

	public SndMsgVO readOneSndMsgByMsgId(String msgId);
	
}

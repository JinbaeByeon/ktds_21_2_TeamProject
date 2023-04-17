package com.kpms.sndmsg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.sndmsg.dao.SndMsgDAO;
import com.kpms.sndmsg.vo.SndMsgVO;

@Service
public class SndMsgServiceImpl implements SndMsgService {

	@Autowired
	private SndMsgDAO sndMsgDAO;

	@Override
	public List<SndMsgVO> readAllSndMsgVO(SndMsgVO sndMsgVO) {
		return sndMsgDAO.readAllSndMsgVO(sndMsgVO);
	}

	@Override
	public boolean createOneSndMsg(SndMsgVO sndMsgVO) {
		return sndMsgDAO.createOneSndMsg(sndMsgVO) > 0;
	}

	@Override
	public boolean updateOneSndMsg(SndMsgVO sndMsgVO) {
		return sndMsgDAO.updateOneSndMsg(sndMsgVO) > 0;
	}

	@Override
	public boolean deleteOneSndMsg(String msgId) {
		return sndMsgDAO.deleteOneSndMsg(msgId) > 0;
	}

	@Override
	public boolean deleteSndMsgBySelectedMsgId(List<Integer> msgId) {
		return sndMsgDAO.deleteSndMsgBySelectedMsgId(msgId) > 0;
	}
	
	
}

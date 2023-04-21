package com.kpms.sndmsg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.rcvmsg.vo.MsgSearchVO;
import com.kpms.sndmsg.dao.SndMsgDAO;
import com.kpms.sndmsg.vo.SndMsgVO;

@Service
public class SndMsgServiceImpl implements SndMsgService {

	@Autowired
	private SndMsgDAO sndMsgDAO;

	@Override
	public List<SndMsgVO> readAllSndMsgVO(MsgSearchVO msgSearchVO) {
		return sndMsgDAO.readAllSndMsgVO(msgSearchVO);
	}

	@Override
	public boolean createOneSndMsg(SndMsgVO sndMsgVO) {
		return false;
	}

	@Override
	public boolean deleteOneSndMsg(String msgId) {
		return false;
	}

	@Override
	public boolean deleteSndMsgBySelectedMsgId(List<String> msgId) {
		return false;
	}
}
package com.kpms.sndmsg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIException;
import com.kpms.rcvmsg.dao.RcvMsgDAO;
import com.kpms.rcvmsg.vo.MsgSearchVO;
import com.kpms.sndmsg.dao.SndMsgDAO;
import com.kpms.sndmsg.vo.SndMsgVO;

@Service
public class SndMsgServiceImpl implements SndMsgService {

	@Autowired
	private SndMsgDAO sndMsgDAO;
	@Autowired
	private RcvMsgDAO rcvMsgDAO;
	
	@Override
	public List<SndMsgVO> readAllSndMsgVO(MsgSearchVO msgSearchVO) {
		return sndMsgDAO.readAllSndMsgVO(msgSearchVO);
	}

	@Override
	public boolean createOneSndMsg(SndMsgVO sndMsgVO) {
		if(sndMsgDAO.createOneSndMsg(sndMsgVO) == 0) {
			throw new APIException(APIStatus.FAIL, "쪽지 발신을 실패하였습니다.");
		}
		if(rcvMsgDAO.createRcvMsg(sndMsgVO) == 0) {
			throw new APIException(APIStatus.FAIL, "쪽지 발신을 실패하였습니다.");
		}
		return true;
	}

	@Override
	public boolean deleteOneSndMsg(String msgId) {
		return sndMsgDAO.deleteOneSndMsg(msgId) > 0;
	}

	@Override
	public boolean deleteSndMsgBySelectedMsgId(List<String> msgId) {
		return sndMsgDAO.deleteSndMsgBySelectedMsgId(msgId) > 0;
	}

	@Override
	public SndMsgVO readOneSndMsgByRcvMsgId(String msgId) {
		return sndMsgDAO.readOneSndMsgByRcvMsgId(msgId);
	}
	@Override
	public SndMsgVO readOneSndMsgByMsgId(String msgId) {
		return sndMsgDAO.readOneSndMsgByMsgId(msgId);
	}
}
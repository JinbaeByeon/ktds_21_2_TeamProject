package com.kpms.rcvmsg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.rcvmsg.dao.RcvMsgDAO;
import com.kpms.rcvmsg.vo.MsgSearchVO;
import com.kpms.rcvmsg.vo.RcvMsgVO;
import com.kpms.sndmsg.vo.SndMsgVO;

@Service
public class RcvMsgServiceImpl implements RcvMsgService{

	@Autowired
	private RcvMsgDAO rcvMsgDAO;
	
	@Override
	public List<RcvMsgVO> readAllRcvMsgVO(MsgSearchVO rcvMsgVO) {
		return rcvMsgDAO.readAllRcvMsgVO(rcvMsgVO);
	}
	
	@Override
	public SndMsgVO readOneSndMsgVO(String rcvmsgId) {
		return rcvMsgDAO.readOneSndMsgVO(rcvmsgId);
	}
	
	@Override
	public boolean createOneRcvMsg(RcvMsgVO rcvMsgVO) {
		return rcvMsgDAO.createOneRcvMsg(rcvMsgVO) > 0;
	}

	@Override
	public boolean deleteOneRcvMsg(String msgId) {
		return rcvMsgDAO.deleteOneRcvMsg(msgId) > 0;
	}


	@Override
	public boolean deleteRcvMsgBySelectedMsgId(List<String> msgId) {
		return rcvMsgDAO.deleteRcvMsgBySelectedMsgId(msgId) > 0;
	}

	@Override
	public boolean updateRcvMsgReadByRcvMsgIdList(List<String> rcvMsgIdList) {
		return rcvMsgDAO.updateRcvMsgReadByRcvMsgIdList(rcvMsgIdList) > 0;
	}
	//휴지통 삭제
	@Override
	public boolean deleteTrashMsg(List<String> rcvMsgIdList) {
		return rcvMsgDAO.deleteTrashMsg(rcvMsgIdList) > 0;
	}
	//디테일
	@Override
	public RcvMsgVO readOneRcvMsg(String msgId) {
		return rcvMsgDAO.readOneRcvMsg(msgId);
	}
	//휴지통 조회
	@Override
	public List<RcvMsgVO> readAllDelMsg(MsgSearchVO msgSearchVO) {
		return rcvMsgDAO.readAllDelMsg(msgSearchVO);
	}

}

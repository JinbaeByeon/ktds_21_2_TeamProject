package com.kpms.rcvmsg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.rcvmsg.dao.RcvMsgDAO;
import com.kpms.rcvmsg.vo.RcvMsgVO;

@Service
public class RcvMsgServiceImpl implements RcvMsgService{

	@Autowired
	private RcvMsgDAO rcvMsgDAO;
	
	@Override
	public List<RcvMsgVO> readAllRcvMsgVO(RcvMsgVO rcvMsgVO) {
		return rcvMsgDAO.readAllRcvMsgVO(rcvMsgVO);
	}
	
	@Override
	public boolean createOneRcvMsg(RcvMsgVO rcvMsgVO) {
		return rcvMsgDAO.createOneRcvMsg(rcvMsgVO) > 0;
	}

	@Override
	public boolean updateOneRcvMsg(RcvMsgVO rcvMsgVO) {
		return rcvMsgDAO.updateOneRcvMsg(rcvMsgVO) > 0;
	}

	@Override
	public boolean deleteOneRcvMsg(int msgId) {
		return rcvMsgDAO.deleteOneRcvMsg(msgId) > 0;
	}


	@Override
	public boolean deleteRcvMsgBySelectedMsgId(List<Integer> msgId) {
		return rcvMsgDAO.deleteRcvMsgBySelectedMsgId(msgId) > 0;
	}

}

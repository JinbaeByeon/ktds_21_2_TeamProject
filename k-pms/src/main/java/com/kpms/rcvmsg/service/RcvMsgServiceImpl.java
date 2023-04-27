package com.kpms.rcvmsg.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.rcvmsg.dao.RcvMsgDAO;
import com.kpms.rcvmsg.vo.MsgSearchVO;
import com.kpms.rcvmsg.vo.MsgVOList;
import com.kpms.rcvmsg.vo.RcvMsgVO;
import com.kpms.sndmsg.dao.SndMsgDAO;
import com.kpms.sndmsg.vo.SndMsgVO;

@Service
public class RcvMsgServiceImpl implements RcvMsgService{

	@Autowired
	private RcvMsgDAO rcvMsgDAO;
	@Autowired
	private SndMsgDAO sndMsgDAO;
	
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
	public boolean deleteTrashMsg(MsgVOList msgVOList) {
		List<String> rcvMsgIdList = new ArrayList<>();
		List<String> sndMsgIdList = new ArrayList<>();
		for(RcvMsgVO msgVO : msgVOList.getRcvMsgVOList()) {
			if(msgVO.getType().equals("RM")) {
				rcvMsgIdList.add(msgVO.getMsgId());
			} else {
				sndMsgIdList.add(msgVO.getMsgId());
			}
		}
		int res=0;
		if(!rcvMsgIdList.isEmpty()) {
			res += rcvMsgDAO.deleteTrashMsg(rcvMsgIdList);
		}
		if(!sndMsgIdList.isEmpty()) {
			res += sndMsgDAO.deleteTrashMsg(sndMsgIdList);
		}
		return res > 0;
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

	@Override
	public boolean restoreRcvMsg(MsgVOList msgVOList) {
		List<String> rcvMsgIdList = new ArrayList<>();
		List<String> sndMsgIdList = new ArrayList<>();
		for(RcvMsgVO msgVO : msgVOList.getRcvMsgVOList()) {
			if(msgVO.getType().equals("RM")) {
				rcvMsgIdList.add(msgVO.getMsgId());
			} else {
				sndMsgIdList.add(msgVO.getMsgId());
			}
		}
		int res=0;
		if(!rcvMsgIdList.isEmpty()) {
			res += rcvMsgDAO.restoreRcvMsg(rcvMsgIdList);
		}
		if(!sndMsgIdList.isEmpty()) {
			/* res += sndMsgDAO.restoreSndMsg(sndMsgIdList); */
		}
		return res > 0;
	}
}

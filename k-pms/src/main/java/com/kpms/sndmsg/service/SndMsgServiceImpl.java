package com.kpms.sndmsg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.atchfl.dao.AtchFlDAO;
import com.kpms.atchfl.vo.AtchFlVO;
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
	@Autowired
	private AtchFlDAO atchFlDAO;
	
	@Override
	public List<SndMsgVO> readAllSndMsgVO(MsgSearchVO msgSearchVO) {
		return sndMsgDAO.readAllSndMsgVO(msgSearchVO);
	}

	@Override
	public boolean createOneSndMsg(SndMsgVO sndMsgVO) {
		List<AtchFlVO> fileList = sndMsgVO.getAtchFlList();
		
		if(sndMsgDAO.createOneSndMsg(sndMsgVO) == 0) {
			throw new APIException(APIStatus.FAIL, "쪽지 발신을 실패하였습니다.");
		}
		if(rcvMsgDAO.createRcvMsg(sndMsgVO) == 0) {
			throw new APIException(APIStatus.FAIL, "쪽지 발신을 실패하였습니다.");
		}
		
		if(!fileList.isEmpty()) {
			fileList.forEach(file-> {
				file.setCrtr(sndMsgVO.getCrtr());
				file.setFrgnId(sndMsgVO.getMsgId());
			});
			if (atchFlDAO.createNewAtchFls(fileList) == 0) {
				return false;
			}
		}
		return true;
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
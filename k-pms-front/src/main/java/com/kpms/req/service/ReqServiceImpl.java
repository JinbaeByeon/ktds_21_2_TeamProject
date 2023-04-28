package com.kpms.req.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.atchfl.dao.AtchFlDAO;
import com.kpms.atchfl.vo.AtchFlVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIException;
import com.kpms.req.dao.ReqDAO;
import com.kpms.req.vo.ReqVO;

@Service
public class ReqServiceImpl implements ReqService{

	@Autowired
	private ReqDAO reqDAO;
	@Autowired
	private AtchFlDAO atchFlDAO;

	@Override
	public boolean createNewReq(ReqVO reqVO) {
		if(reqDAO.createNewReq(reqVO) == 0) {
			return false;
		}
		List<AtchFlVO> fileList = reqVO.getAtchFlList();
		
		if(fileList != null && !fileList.isEmpty()) {
			fileList.forEach(file-> {
				file.setCrtr(reqVO.getCrtr());
				file.setFrgnId(reqVO.getReqId());
			});
			if (atchFlDAO.createNewAtchFls(fileList) == 0) {
				throw new APIException(APIStatus.FAIL, "파일 첨부를 실패했습니다.");
			}
		}
		return true;
	}

	@Override
	public List<ReqVO> readAllReq(ReqVO reqVO) {
		return reqDAO.readAllReq(reqVO);
	}

	@Override
	public ReqVO readReqByReqId(String reqId) {
		return reqDAO.readReqByReqId(reqId);
	}

	@Override
	public boolean updateReq(ReqVO reqVO) {
		
		List<AtchFlVO> fileList = reqVO.getAtchFlList();
		atchFlDAO.deleteAtchFlsByFrgnId(reqVO.getReqId());
		
		if(fileList != null && !fileList.isEmpty()) {
			fileList.forEach(file-> {
				file.setCrtr(reqVO.getMdfyr());
				file.setFrgnId(reqVO.getReqId());
			});
			if (atchFlDAO.createNewAtchFls(fileList) != fileList.size()) {
				throw new APIException(APIStatus.FAIL, "파일 첨부를 실패했습니다.");
			}
		}
		return reqDAO.updateReq(reqVO) > 0;
	}

	@Override
	public boolean deleteReqByReqId(String reqId) {
		return reqDAO.deleteReqByReqId(reqId) > 0;
	}

	@Override
	public boolean deleteReqBySelectedReqId(List<String> reqId) {
		return reqDAO.deleteReqBySelectedReqId(reqId) > 0;
	}

}

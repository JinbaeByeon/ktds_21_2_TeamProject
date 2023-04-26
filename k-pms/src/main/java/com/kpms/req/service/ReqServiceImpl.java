package com.kpms.req.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.atchfl.dao.AtchFlDAO;
import com.kpms.atchfl.vo.AtchFlVO;
import com.kpms.req.dao.ReqDAO;
import com.kpms.req.vo.ReqSearchVO;
import com.kpms.req.vo.ReqVO;

@Service
public class ReqServiceImpl implements ReqService {

	@Autowired
	private ReqDAO reqDAO;
	@Autowired
	private AtchFlDAO atchFlDAO;

	@Override
	public boolean createNewReq(ReqVO reqVO) {
		reqDAO.createNewReq(reqVO);
		
		List<AtchFlVO> fileList = reqVO.getAtchFlList();
		
		if(!fileList.isEmpty()) {
			fileList.forEach(file-> {
				file.setCrtr(reqVO.getCrtr());
				file.setFrgnId(reqVO.getReqId());
			});
			if (atchFlDAO.createNewAtchFls(fileList) == 0) {
				return false;
			}
		}
		return true;
	}

	@Override
	public List<ReqVO> readAllReqSearch(ReqSearchVO reqSearchVO) {
		return reqDAO.readAllReqSearch(reqSearchVO);
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
		reqDAO.updateReq(reqVO);
		List<AtchFlVO> fileList = reqVO.getAtchFlList();
		
		if(!fileList.isEmpty()) {
			fileList.forEach(file-> {
				file.setCrtr(reqVO.getCrtr());
				file.setFrgnId(reqVO.getReqId());
			});
			if (atchFlDAO.createNewAtchFls(fileList) == 0) {
				return false;
			}
		}
		return true;
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

package com.kpms.req.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.req.dao.ReqDAO;
import com.kpms.req.vo.ReqVO;

@Service
public class ReqServiceImpl implements ReqService{

	@Autowired
	private ReqDAO reqDAO;

	@Override
	public boolean createNewReq(ReqVO reqVO) {
		return reqDAO.createNewReq(reqVO) > 0;
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

	@Override
	public List<String> readPrjIdByEmpId(String empId) {
		return reqDAO.readPrjIdByEmpId(empId);
	}
}

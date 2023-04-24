package com.kpms.req.service;

import java.util.List;

import com.kpms.req.vo.ReqVO;

public interface ReqService {

	public boolean createNewReq(ReqVO reqVO);
	public List<ReqVO> readAllReq(ReqVO reqVO);
	public List<ReqVO> readReqByReqId(String reqId);
	public boolean updateReq(ReqVO reqVO);
	public boolean deleteReqByReqId(String reqId);
	public boolean deleteReqBySelectedReqId(List<String> reqId);
}

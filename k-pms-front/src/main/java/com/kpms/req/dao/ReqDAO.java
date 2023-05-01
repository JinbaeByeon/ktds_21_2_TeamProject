package com.kpms.req.dao;

import java.util.List;

import com.kpms.req.vo.ReqVO;

public interface ReqDAO {

	public int createNewReq(ReqVO reqVO);
	public List<ReqVO> readAllReq(ReqVO reqVO);
	
	public ReqVO readReqByReqId(String reqId);
	public int updateReq(ReqVO reqVO);
	public int deleteReqByReqId(String reqId);
	public int deleteReqBySelectedReqId(List<String> reqId);
	public int deleteReqByPrjId(String prjId);
	
}

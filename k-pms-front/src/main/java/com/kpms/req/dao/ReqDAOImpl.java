package com.kpms.req.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.req.vo.ReqSearchVO;
import com.kpms.req.vo.ReqVO;
@Repository
public class ReqDAOImpl extends SqlSessionDaoSupport implements ReqDAO{

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public int createNewReq(ReqVO reqVO) {
		return getSqlSession().insert("Req.createNewReq", reqVO);
	}
	
	@Override
	public List<ReqVO> readAllReqSearch(ReqSearchVO reqSearchVO) {
		return getSqlSession().selectList("Req.readAllReqSearch", reqSearchVO);
	}
	@Override
	public List<ReqVO> readAllReq(ReqVO reqVO) {
		return getSqlSession().selectList("Req.readAllReq", reqVO);
	}

	@Override
	public ReqVO readReqByReqId(String reqId) {
		return getSqlSession().selectOne("Req.readReqByReqId", reqId);
	}

	@Override
	public int updateReq(ReqVO reqVO) {
		return getSqlSession().update("Req.updateReq", reqVO);
	}

	@Override
	public int deleteReqByReqId(String reqId) {
		return getSqlSession().update("Req.deleteReqByReqId", reqId);
	}

	@Override
	public int deleteReqBySelectedReqId(List<String> reqId) {
		return getSqlSession().update("Req.deleteReqBySelectedReqId", reqId);
	}
	
	@Override
	public int deleteReqByPrjId(String prjId) {
		return getSqlSession().update("Req.deleteReqByPrjId", prjId);
	}

}

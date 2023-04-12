package com.kpms.eqp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.kpms.eqp.vo.EqpVO;

@Repository
public class EqpDAOImpl extends SqlSessionDaoSupport implements EqpDAO{

	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public int createNewEqp(EqpVO eqpVO) {
		return getSqlSession().insert("Eqp.createNewEqp", eqpVO);
	}

	@Override
	public List<EqpVO> readAllEqp(EqpVO eqpVO) {
		return getSqlSession().selectList("Eqp.readAllEqp", eqpVO);
	}

	@Override
	public int updateEqp(EqpVO eqpVO) {
		return getSqlSession().update("Eqp.updateEqp", eqpVO);
	}

	@Override
	public int deleteEqpByEqpId(String eqpId) {
		return getSqlSession().update("Eqp.deleteEqpByEpqId", eqpId);
	}

	@Override
	public int deleteEqpBySelectedEqpId(List<String> eqpId) {
		return getSqlSession().update("Eqp.deleteEqpBySelectedEqpId", eqpId);
	}


	
}

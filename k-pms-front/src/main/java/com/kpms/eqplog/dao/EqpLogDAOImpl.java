package com.kpms.eqplog.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.eqplog.vo.EqpLogVO;

@Repository
public class EqpLogDAOImpl extends SqlSessionDaoSupport implements EqpLogDAO{
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public int createEqpLog(EqpLogVO eqpLogVO) {
		return getSqlSession().insert("Eqp.createEqpLog", eqpLogVO);
	}

	@Override
	public List<EqpLogVO> readAllEqpLog(EqpLogVO eqpLogVO) {
		return getSqlSession().selectList("Eqp.readAllEqpLog", eqpLogVO);
	}
	
}

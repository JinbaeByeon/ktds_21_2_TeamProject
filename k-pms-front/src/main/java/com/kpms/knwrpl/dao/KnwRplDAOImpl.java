package com.kpms.knwrpl.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.knwrpl.vo.KnwRplVO;

@Repository
public class KnwRplDAOImpl extends SqlSessionDaoSupport implements KnwRplDAO {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public int createNewKnwRpl(KnwRplVO knwRplVO) {
		return getSqlSession().insert("KnwRpl.createNewKnwRpl", knwRplVO);
	}

	@Override
	public int updateOneKnwRpl(KnwRplVO knwRplVO) {
		return getSqlSession().update("KnwRpl.updateOneKnwRpl", knwRplVO);
	}

	@Override
	public int deleteOneKnwRpl(String rplId) {
		return getSqlSession().update("KnwRpl.deleteOneKnwRpl", rplId);
	}

	@Override
	public int deleteSelectedKnwRplByKnwId(String knwId) {
		return getSqlSession().update("KnwRpl.deleteSelectedKnwRplByKnwId", knwId);
	}
	
	
}

package com.kpms.atchfl.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.atchfl.vo.AtchFlVO;

@Repository
public class AtchFlDAOImpl extends SqlSessionDaoSupport implements AtchFlDAO {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	
	@Override
	public int createNewAtchFl(AtchFlVO atchFlVO) {
		return getSqlSession().insert("AtchFl.doCreateNewAtchFl", atchFlVO);
	}
	
	@Override
	public int deleteNewAtchFl(AtchFlVO atchFlVO) {
		return getSqlSession().update("AtchFl.doDeleteNewAtchFl", atchFlVO);
	}
}

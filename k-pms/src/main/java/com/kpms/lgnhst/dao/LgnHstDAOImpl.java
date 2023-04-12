package com.kpms.lgnhst.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.lgnhst.vo.LgnHstVO;

@Repository
public class LgnHstDAOImpl extends SqlSessionDaoSupport implements LgnHstDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	@Override
	public int createEmpLgnHst(LgnHstVO lgnHst) {
		return 0;
		/* return getSqlSession().insert("LgnHst.createEmpLgnHst",lgnHst); */
	}

}

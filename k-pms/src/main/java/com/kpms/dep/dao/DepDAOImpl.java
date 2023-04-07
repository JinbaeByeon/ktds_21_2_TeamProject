package com.kpms.dep.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.dep.vo.DepVO;

@Repository
public class DepDAOImpl extends SqlSessionDaoSupport implements DepDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public int createOneDep(DepVO depVO) {
		return getSqlSession().insert("Dep.createOneDep", depVO);
	}
}

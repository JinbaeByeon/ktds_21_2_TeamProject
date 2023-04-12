package com.kpms.knw.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.knw.vo.KnwVO;

@Repository
public class KnwDAOImpl extends SqlSessionDaoSupport implements KnwDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public int createOneKnw(KnwVO knwVO) {
		return getSqlSession().insert("Knw.createOneKnw", knwVO);
	}

	@Override
	public List<KnwVO> readAllKnw(KnwVO knwVO) {
		return getSqlSession().selectList("Knw.readAllKnw", knwVO);
	}

	
}

package com.kpms.atchfl.dao;

import java.util.List;

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
		return getSqlSession().insert("AtchFl.createNewAtchFl", atchFlVO);
	}
	
	@Override
	public int deleteNewAtchFl(String frgnId) {
		return getSqlSession().update("AtchFl.deleteNewAtchFl", frgnId);
	}

	@Override
	public int createNewAtchFls(List<AtchFlVO> fileList) {
		return getSqlSession().insert("AtchFl.createNewAtchFls", fileList);
	}
}

package com.kpms.issu.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.issu.vo.IssuVO;

@Repository
public class IssuDAOImpl extends SqlSessionDaoSupport implements IssuDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public int createOneIssu(IssuVO issuVO) {
		return getSqlSession().insert("Issu.createOneIssu",issuVO);
	}

	@Override
	public IssuVO readOneIssu(String issuId) {
		return getSqlSession().selectOne("Issu.readOneIssu",issuId);
	}

	@Override
	public List<IssuVO> readIssuList(IssuVO issuVO) {
		return getSqlSession().selectList("Issu.readIssuList",issuVO);
	}

	@Override
	public int updateOneIssu(IssuVO issuVO) {
		return getSqlSession().update("Issu.updateOneIssu",issuVO);
	}
	@Override
	public int updateIssuVwCnt(String issuId) {
		return getSqlSession().update("Issu.updateIssuVwCnt",issuId);
	}

	@Override
	public int deleteOneIssu(String issuId) {
		return getSqlSession().update("Issu.deleteOneIssu",issuId);
	}

}

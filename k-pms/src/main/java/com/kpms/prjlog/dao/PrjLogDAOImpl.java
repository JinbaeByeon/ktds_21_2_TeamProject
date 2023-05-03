package com.kpms.prjlog.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.prjlog.vo.PrjLogVO;

@Repository
public class PrjLogDAOImpl extends SqlSessionDaoSupport implements PrjLogDAO {
	
	@Autowired
	@Override
	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
		super.setSqlSessionFactory(sqlSessionFactory);
	}

	@Override
	public int createPrjLog(PrjLogVO prjLogVO) {
		return getSqlSession().insert("PrjLog.createPrjLog", prjLogVO);
	}

	@Override
	public List<PrjLogVO> readAllPrjLog(PrjLogVO prjLogVO) {
		return getSqlSession().selectList("PrjLog.readAllPrjLog", prjLogVO);
	}
	
}

package com.kpms.lgntrylog.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.lgntrylog.vo.LgnTryLogVO;

@Repository
public class LgnTryLogDAOImpl extends SqlSessionDaoSupport implements LgnTryLogDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	
	
	@Override
	public int updateLgnTryLog(LgnTryLogVO lgnTryLog) {
		return getSqlSession().insert("LgnTryLog.updateLgnTryLog",lgnTryLog);
	}

	@Override
	public LgnTryLogVO readLgnTryLog(LgnTryLogVO lgnTryLog) {
		return getSqlSession().selectOne("LgnTryLog.readLgnTryLogByIp",lgnTryLog);
	}



	@Override
	public int createLgnTryLog(LgnTryLogVO lgnTryLog) {
		return 0;
	}

}

package com.kpms.acslog.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.acslog.vo.AcsLogVO;

@Repository
public class AcsLogDAOImpl extends SqlSessionDaoSupport implements AcsLogDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public int createAcsLog(AcsLogVO acsLog) {
		return getSqlSession().insert("AcsLog.createAcsLog",acsLog);
	}

	@Override
	public List<AcsLogVO> readAllAcsLog(AcsLogVO acsLog) {
		return getSqlSession().selectList("AcsLog.readAllAcsLog",acsLog);
	}

}

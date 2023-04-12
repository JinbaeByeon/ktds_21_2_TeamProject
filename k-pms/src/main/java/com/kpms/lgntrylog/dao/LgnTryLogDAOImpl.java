package com.kpms.lgntrylog.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.emp.vo.EmpVO;
import com.kpms.lgntrylog.vo.LgnTryLogVO;

@Repository
public class LgnTryLogDAOImpl extends SqlSessionDaoSupport implements LgnTryLogDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public int createLgnTryLog(EmpVO empVO) {
		return getSqlSession().insert("LgnTryLog.createLgnTryLog",empVO);
	}
	
	@Override
	public List<LgnTryLogVO> readLgnTryLogByIp(String lgnTryIp) {
		return getSqlSession().selectList("LgnTryLog.readLgnTryLogByIp",lgnTryIp);
	}

}

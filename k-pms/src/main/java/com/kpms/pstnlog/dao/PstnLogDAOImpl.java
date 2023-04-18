package com.kpms.pstnlog.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.pstnlog.vo.PstnLogVO;

@Repository
public class PstnLogDAOImpl extends SqlSessionDaoSupport implements PstnLogDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public List<PstnLogVO> readAllPstnLogVO(PstnLogVO pstnLogVO) {
		return getSqlSession().selectList("PstnLog.readAllPstnLogVO", pstnLogVO);
	}
	
	@Override
	public int createPstnLog(PstnLogVO pstnLogVO) {
		return getSqlSession().insert("PstnLog.createPstnLog", pstnLogVO);
	}

}

package com.kpms.tmmbr.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.kpms.tmmbr.vo.TmMbrVO;

@Repository
public class TmMbrDAOImpl extends SqlSessionDaoSupport implements TmMbrDAO{
	
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public int createNewTmMbr(TmMbrVO tmMbrVO) {
		return getSqlSession().insert("TmMbr.createNewTmMbr", tmMbrVO);
	}


	@Override
	public int deleteOneTmMbrByTmMbrId(String TmMbrId) {
		return getSqlSession().update("TmMbr.deleteOneTmMbrByTmMbrId", TmMbrId);
	}

}

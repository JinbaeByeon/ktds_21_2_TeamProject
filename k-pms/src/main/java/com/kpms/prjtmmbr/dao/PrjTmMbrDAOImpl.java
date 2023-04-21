package com.kpms.prjtmmbr.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.prjtmmbr.vo.PrjTmMbrVO;

@Repository
public class PrjTmMbrDAOImpl extends SqlSessionDaoSupport implements PrjTmMbrDAO {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public int createNewPrjTmMbr(PrjTmMbrVO prjTmMbrVO) {
		return getSqlSession().insert("PrjTmMbr.createNewPrjTmMbr", prjTmMbrVO);
	}

	@Override
	public int deleteOnePrjTmMbrByPrjTmMbrId(String prjTmMbrId) {
		return getSqlSession().update("PrjTmMbr.deleteOnePrjTmMbrByPrjTmMbrId", prjTmMbrId);
	}

	@Override
	public int updateOnePrjTmMbr(PrjTmMbrVO prjTmMbrVO) {
		return getSqlSession().update("PrjTmMbr.updateOnePrjTmMbr", prjTmMbrVO);
	}
	
}

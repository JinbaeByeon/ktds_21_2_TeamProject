package com.kpms.tmmbr.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.tmmbr.vo.TmMbrVO;

@Repository
public class TmMbrDAOImpl extends SqlSessionDaoSupport implements TmMbrDAO {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public List<TmMbrVO> readAllTmMbrVO(String tmId) {
		return getSqlSession().selectList("TmMbr.readAllTmMbrVO", tmId);
	}
	
	@Override
	public List<TmMbrVO> readAllTmMbrInTm(String tmId) {
		return getSqlSession().selectList("TmMbr.readAllTmMbrInTm", tmId);
	}

	@Override
	public int createOneTmMbr(TmMbrVO tmMbrVO) {
		return getSqlSession().insert("TmMbr.createOneTmMbr", tmMbrVO);
	}
	
	@Override
	public int deleteOneTmMbrByTmMbrId(String tmMbrId) {
		return getSqlSession().update("TmMbr.deleteOneTmMbrByTmMbrId", tmMbrId);
	}

	@Override
	public int deleteTmMbrByTmId(String tmId) {
		return getSqlSession().update("TmMbr.deleteTmMbrByTmId", tmId);
	}
	
	@Override
	public int deleteTmMbrBySelectedTmMbrId(List<String> tmMbrId) {
		return getSqlSession().update("TmMbr.deleteTmMbrBySelectedTmMbrId", tmMbrId);
	}

	@Override
	public int deleteTmMbrByDepId(String depId) {
		return getSqlSession().update("TmMbr.deleteTmMbrByDepId", depId);
	}

	@Override
	public int deleteTmMbrByTmMbrId(String tmMbrId) {
		return getSqlSession().update("TmMbr.deleteTmMbrByTmMbrId", tmMbrId);
	}

}

package com.kpms.pstn.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.pstn.vo.PstnVO;

@Repository
public class PstnDAOImpl extends SqlSessionDaoSupport implements PstnDAO{

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public int createNewPstn(PstnVO pstnVO) {
		return getSqlSession().insert("Pstn.", pstnVO);
	}

	@Override
	public int readPstnByPstnId(String pstnId) {
		return getSqlSession().selectOne("Pstn.readPstnByPstnId", pstnId);
	}

	@Override
	public List<PstnVO> readAllPstn(PstnVO pstnVO) {
		return getSqlSession().selectList("Pstn.readAllPstn", pstnVO);
	}

	@Override
	public int updateNewPstn(PstnVO pstnVO) {
		return getSqlSession().update("Pstn.updateNewPstn", pstnVO);
	}

	@Override
	public int deletePstnByPstnId(String pstnId) {
		return getSqlSession().update("Pstn.deletePstnByPstnId", pstnId);
	}





	

	

}

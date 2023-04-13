package com.kpms.pstn.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.pstn.vo.PstnVO;

@Repository
public class PstnDAOImpl extends SqlSessionDaoSupport implements PstnDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public int createNewPstn(PstnVO pstnVO) {
		return getSqlSession().insert("Pstn.createNewPstn", pstnVO);
	}

	@Override
	public List<PstnVO> readAllPstn(PstnVO pstnVO) {
		return getSqlSession().selectList("Pstn.readAllPstn", pstnVO);
	}

	@Override
	public List<PstnVO> readAllPstnNoPagination(String pstnNm) {
		return getSqlSession().selectList("Pstn.readAllPstnNoPagination", pstnNm);
	}
	
	@Override
	public int updateNewPstn(PstnVO pstnVO) {
		return getSqlSession().update("Pstn.updateNewPstn", pstnVO);
	}

	@Override
	public int deletePstnByPstnId(int pstnId) {
		return getSqlSession().update("Pstn.deletePstnByPstnId", pstnId);
	}

	@Override
	public int deletePstnBySelectedPstnId(List<Integer> pstnId) {
		return getSqlSession().update("Pstn.deletePstnBySelectedPstnId", pstnId);
	}

	

}

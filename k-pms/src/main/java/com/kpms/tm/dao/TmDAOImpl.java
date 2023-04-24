package com.kpms.tm.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.tm.vo.TmSearchVO;
import com.kpms.tm.vo.TmVO;

@Repository
public class TmDAOImpl extends SqlSessionDaoSupport implements TmDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<TmVO> readAllTmVO(TmSearchVO tmSearchVO) {
		return getSqlSession().selectList("Tm.readAllTmVO", tmSearchVO);
	}
	
	@Override
	public List<TmVO> readAllTmVOAndTmMbrVO(String tmId) {
		return getSqlSession().selectList("Tm.readAllTmVOAndTmMbrVO", tmId);
	}

	@Override
	public List<TmVO> readAllTmVONopagination(String tmNm) {
		return getSqlSession().selectList("Tm.readAllTmVONopagination", tmNm);
	}

	@Override
	public TmVO readOneTmVOByTmId(String tmId) {
		return getSqlSession().selectOne("Tm.readOneTmVOByTmId", tmId);
	}

	@Override
	public int createOneTm(TmVO tmVO) {
		return getSqlSession().insert("Tm.createOneTm", tmVO);
	}

	@Override
	public int updateOneTm(TmVO tmVO) {
		return getSqlSession().update("Tm.updateOneTm", tmVO);
	}

	@Override
	public int deleteOneTmByTmId(String tmId) {
		return getSqlSession().update("Tm.deleteOneTmByTmId", tmId);
	}

	@Override
	public int deleteTmBySelectedTmId(List<String> tmId) {
		return getSqlSession().update("Tm.deleteTmBySelectedTmId", tmId);
	}

}

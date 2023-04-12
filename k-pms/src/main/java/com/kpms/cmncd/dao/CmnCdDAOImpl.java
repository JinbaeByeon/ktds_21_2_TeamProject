package com.kpms.cmncd.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.cmncd.vo.CmnCdVO;

@Repository
public class CmnCdDAOImpl extends SqlSessionDaoSupport implements CmnCdDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<CmnCdVO> readAllCmnCd(CmnCdVO cmnCdVO) {
		return getSqlSession().selectList("CmnCd.readAllCmnCd", cmnCdVO);
	}
	
	@Override
	public int createOneCmnCd(CmnCdVO cmnCdVO) {
		return getSqlSession().insert("CmnCd.createOneCmnCd", cmnCdVO);
	}

	@Override
	public int updateOneCmnCd(CmnCdVO cmnCdVO) {
		return getSqlSession().update("CmnCd.updateOneCmnCd", cmnCdVO);
	}

	@Override
	public int deleteOneCmnCdByCdId(int cdId) {
		return getSqlSession().update("CmnCd.deleteOneCmnCdByCdId", cdId);
	}

}

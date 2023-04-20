package com.kpms.cmncd.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.cmncd.vo.CmnCdSearchVO;
import com.kpms.cmncd.vo.CmnCdVO;

@Repository
public class CmnCdDAOImpl extends SqlSessionDaoSupport implements CmnCdDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<CmnCdVO> readAllCmnCd(CmnCdSearchVO cmnCdSearchVO) {
		return getSqlSession().selectList("CmnCd.readAllCmnCd", cmnCdSearchVO);
	}
	
	@Override
	public List<CmnCdVO> readCmnCdType() {
		return getSqlSession().selectList("CmnCd.readCmnCdType");
	}
	
	@Override
	public List<CmnCdVO> readCmnCdNameByPrcdncCdId(String prcdncCdId) {
		return getSqlSession().selectList("CmnCd.readCmnCdNameByPrcdncCdId", prcdncCdId);
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
	public int deleteOneCmnCdByCdId(String cdId) {
		return getSqlSession().update("CmnCd.deleteOneCmnCdByCdId", cdId);
	}

	@Override
	public int deleteCmnCdBySelectedCmnCdId(List<String> cdIdList) {
		return getSqlSession().update("CmnCd.deleteCmnCdBySelectedCmnCdId", cdIdList);
	}
}

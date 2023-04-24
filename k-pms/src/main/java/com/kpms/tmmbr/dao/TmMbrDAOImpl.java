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

}

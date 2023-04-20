package com.kpms.deplog.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.deplog.vo.DepLogVO;
import com.kpms.emp.vo.EmpChngDepVO;

@Repository
public class DepLogDAOImpl extends SqlSessionDaoSupport implements DepLogDAO{

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<DepLogVO> readAllDepLogVO(DepLogVO depLogVO) {
		return getSqlSession().selectList("DepLog.readAllDepLogVO", depLogVO);
	}

	@Override
	public int createDepLog(EmpChngDepVO empChngDepVO) {
		return getSqlSession().update("DepLog.createDepLog",empChngDepVO);
	}

}

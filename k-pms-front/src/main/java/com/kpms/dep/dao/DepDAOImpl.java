package com.kpms.dep.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.dep.vo.DepVO;
import com.kpms.dep.vo.DeptSearchVO;

@Repository
public class DepDAOImpl extends SqlSessionDaoSupport implements DepDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<DepVO> readAllDepVO(DeptSearchVO deptSearchVO) {
		return getSqlSession().selectList("Dep.readAllDepVO", deptSearchVO);
	}
	
	@Override
	public List<DepVO> readAllDepVONopagination(String depNm) {
		return getSqlSession().selectList("Dep.readAllDepVONopagination", depNm);
	}
	
	@Override
	public DepVO readOneDepVOByDepId(String depId) {
		return getSqlSession().selectOne("Dep.readOneDepVOByDepId", depId);
	}
	
	@Override
	public List<DepVO> readAllDepToTmMbr(DepVO depVO) {
		return getSqlSession().selectList("Dep.readAllDepToTmMbr", depVO);
	}

	

}

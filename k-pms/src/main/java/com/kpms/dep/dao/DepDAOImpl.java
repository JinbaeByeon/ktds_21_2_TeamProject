package com.kpms.dep.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.dep.vo.DepVO;

@Repository
public class DepDAOImpl extends SqlSessionDaoSupport implements DepDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<DepVO> readAllDepVO(DepVO depVO) {
		return getSqlSession().selectList("Dep.readAllDepVO", depVO);
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
	public int createOneDep(DepVO depVO) {
		return getSqlSession().insert("Dep.createOneDep", depVO);
	}


	@Override
	public int updateOneDepByDepId(DepVO depVO) {
		return getSqlSession().update("Dep.updateOneDepByDepId", depVO);
	}

	@Override
	public int deleteOneDepByDepId(String depId) {
		return getSqlSession().update("Dep.deleteOneDepByDepId", depId);
	}

	@Override
	public int deleteDepBySelectedDepId(List<String> depId) {
		return getSqlSession().update("Dep.deleteDepBySelectedDepId", depId);
	}

	

}

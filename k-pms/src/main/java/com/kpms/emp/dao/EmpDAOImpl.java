package com.kpms.emp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.emp.vo.EmpVO;

@Repository
public class EmpDAOImpl extends SqlSessionDaoSupport implements EmpDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public int createOneEmp(EmpVO empVO) {
		return getSqlSession().insert("Emp.createOneEmp",empVO);
	}

	@Override
	public EmpVO readOneEmpByIdAndPwd(EmpVO empVO) {
		return getSqlSession().selectOne("Emp.createOneEmp",empVO);
	}

	@Override
	public EmpVO readOneEmpByEmpId(String empId) {
		return getSqlSession().selectOne("Emp.createOneEmp",empId);
	}

	@Override
	public List<EmpVO> readEmpList(EmpVO empVO) {
		return getSqlSession().selectList("Emp.createOneEmp",empVO);
	}

	@Override
	public int updateOneEmp(EmpVO empVO) {
		return getSqlSession().update("Emp.createOneEmp",empVO);
	}

	@Override
	public int deleteOneEmp(EmpVO empVO) {
		return getSqlSession().update("Emp.createOneEmp",empVO);
	}
	
}

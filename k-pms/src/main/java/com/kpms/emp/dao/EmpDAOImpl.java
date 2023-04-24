package com.kpms.emp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.emp.vo.EmpChngDepVO;
import com.kpms.emp.vo.EmpChngJobVO;
import com.kpms.emp.vo.EmpChngPstnVO;
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
	public int readCntPwdChngDtMore90ById(String empId) {
		return getSqlSession().selectOne("Emp.readCntPwdChngDtMore90ById",empId);
	}
	@Override
	public String readSaltById(String empId) {
		return getSqlSession().selectOne("Emp.readSaltById",empId);
	}
	@Override
	public int readCntLgnTryDataRcnt60ById(String empId) {
		return getSqlSession().selectOne("Emp.readCntLgnTryDataRcnt60ById",empId);
	}
	@Override
	public EmpVO readLgnTryDataById(String empId) {
		return getSqlSession().selectOne("Emp.readLgnTryDataById",empId);
	}
	@Override
	public EmpVO readOneEmpByIdAndPwd(EmpVO empVO) {
		return getSqlSession().selectOne("Emp.readOneEmpByIdAndPwd",empVO);
	}
	@Override
	public EmpVO readOneEmpByEmpId(String empId) {
		return getSqlSession().selectOne("Emp.readOneEmpByEmpId",empId);
	}
	
	@Override
	public List<EmpVO> readEmpListNoPagination(EmpVO empVO) {
		return getSqlSession().selectList("Emp.readEmpListNoPagination",empVO);
	}

	@Override
	public List<EmpVO> readEmpOnTmMbrListNoPagination(EmpVO empVO) {
		return getSqlSession().selectList("Emp.readEmpOnTmMbrListNoPagination", empVO);
	}
	
	@Override
	public List<EmpVO> readEmpList(EmpVO empVO) {
		return getSqlSession().selectList("Emp.readEmpList",empVO);
	}

	@Override
	public int updateOneEmp(EmpVO empVO) {
		return getSqlSession().update("Emp.updateOneEmp",empVO);
	}
	@Override
	public int updateEmpLgnSucc(EmpVO empVO) {
		return getSqlSession().update("Emp.updateEmpLgnSucc",empVO);
	}
	@Override
	public int updateEmpLgnFail(String empId) {
		return getSqlSession().update("Emp.updateEmpLgnFail",empId);
	}
	@Override
	public int updateEmpLgnCntZero(String empId) {
		return getSqlSession().update("Emp.updateEmpLgnCntZero",empId);
	}
	
	@Override
	public int deleteOneEmp(EmpVO empVO) {
		return getSqlSession().update("Emp.deleteOneEmp",empVO);
	}

	@Override
	public int updateEmpJob(EmpChngJobVO empChngJobVO) {
		return getSqlSession().update("Emp.updateEmpJob",empChngJobVO);
	}

	@Override
	public int updateEmpPstn(EmpChngPstnVO empChngPstnVO) {
		return getSqlSession().update("Emp.updateEmpPstn",empChngPstnVO);
	}

	@Override
	public int updateEmpDep(EmpChngDepVO empChngDepVO) {
		return getSqlSession().update("Emp.updateEmpDep",empChngDepVO);
	}

	@Override
	public int deleteEmpByDepId(String depId) {
		return getSqlSession().update("Emp.deleteEmpByDepId", depId);
	}

}

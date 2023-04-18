package com.kpms.emp.service;

import java.util.List;

import com.kpms.emp.vo.EmpVO;
import com.kpms.lgnhst.vo.LgnHstVO;

public interface EmpService {

	public boolean createOneEmp(EmpVO empVO);
	
	public boolean readPwdChngDtMore90ById(String empId);
	
	public EmpVO readOneEmpByIdAndPwd(EmpVO empVO);
	public EmpVO readOneEmpByEmpId(String empId);
	
	public List<EmpVO> readEmpListNoPagination(EmpVO empVO);
	public List<EmpVO> readEmpList(EmpVO empVO);
	
	public boolean updateOneEmp(EmpVO empVO);
	
	public boolean deleteOneEmp(EmpVO empVO);

	public boolean createLgnHst(LgnHstVO lgnHst);

}

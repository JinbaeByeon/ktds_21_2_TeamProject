package com.kpms.emp.dao;

import java.util.List;

import com.kpms.emp.vo.EmpVO;

public interface EmpDAO {

	public int createOneEmp(EmpVO empVO);
	
	public EmpVO readOneEmpByIdAndPwd(EmpVO empVO);
	public EmpVO readOneEmpByEmpId(String empId);
	
	public List<EmpVO> readEmpList(EmpVO empVO);
	
	public int updateOneEmp(EmpVO empVO);
	
	public int deleteOneEmp(EmpVO empVO);
}

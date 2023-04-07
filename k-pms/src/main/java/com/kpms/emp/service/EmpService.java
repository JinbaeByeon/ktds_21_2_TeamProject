package com.kpms.emp.service;

import java.util.List;

import com.kpms.emp.vo.EmpVO;

public interface EmpService {

	public boolean createOneEmp(EmpVO empVO);
	
	public EmpVO readOneEmpByIdAndPwd(EmpVO empVO);
	public EmpVO readOneEmpByEmpId(String empId);
	
	public List<EmpVO> readEmpList(EmpVO empVO);
	
	public boolean updateOneEmp(EmpVO empVO);
	
	public boolean deleteOneEmp(EmpVO empVO);

}

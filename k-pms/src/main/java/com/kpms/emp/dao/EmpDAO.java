package com.kpms.emp.dao;

import java.util.List;

import com.kpms.emp.vo.EmpVO;

public interface EmpDAO {

	public int createOneEmp(EmpVO empVO);

	public int readCntLgnTryDataRcnt60ById(String empId);
	public EmpVO readLgnTryDataById(String empId);
	public EmpVO readOneEmpByIdAndPwd(EmpVO empVO);
	public EmpVO readOneEmpByEmpId(String empId);
	
	public List<EmpVO> readEmpListNoPagination(EmpVO empVO);
	public List<EmpVO> readEmpList(EmpVO empVO);
	
	public int updateOneEmp(EmpVO empVO);
	public int updateEmpLgnSucc(EmpVO empVO);
	
	public int deleteOneEmp(EmpVO empVO);

	public int updateEmpLgnFail(String empId);


	public int updateEmpLgnCntZero(String empId);

	public String readSaltById(String empId);
}

package com.kpms.emp.dao;

import java.util.List;

import com.kpms.emp.vo.EmpChngDepVO;
import com.kpms.emp.vo.EmpChngEmplmntVO;
import com.kpms.emp.vo.EmpChngJobVO;
import com.kpms.emp.vo.EmpChngPstnVO;
import com.kpms.emp.vo.EmpVO;

public interface EmpDAO {

	public int createOneEmp(EmpVO empVO);

	public int readCntPwdChngDtMore90ById(String empId);
	public String readSaltById(String empId);
	public int readCntLgnTryDataRcnt60ById(String empId);
	public EmpVO readLgnTryDataById(String empId);
	public EmpVO readOneEmpByIdAndPwd(EmpVO empVO);
	public EmpVO readOneEmpByEmpId(String empId);
	
	public List<EmpVO> readEmpListNoPagination(EmpVO empVO);
	public List<EmpVO> readEmpOnTmMbrListNoPagination(EmpVO empVO);
	public List<EmpVO> readEmpList(EmpVO empVO);
	
	public int updateOneEmp(EmpVO empVO);
	public int updateEmpLgnSucc(EmpVO empVO);
	
	public int deleteOneEmp(EmpVO empVO);

	public int updateEmpLgnFail(String empId);

	public int updateEmpLgnCntZero(String empId);

	public int updateEmpJob(EmpChngJobVO empChngJobVO);
	public int updateEmpPstn(EmpChngPstnVO empChngPstnVO);
	public int updateEmpDep(EmpChngDepVO empChngDepVO);
	
	public int updateEmpEmplmnt(EmpChngEmplmntVO empChngEmplmntVO);

}

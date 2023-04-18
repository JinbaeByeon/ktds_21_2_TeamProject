package com.kpms.emp.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kpms.emp.vo.EmpPwdVO;
import com.kpms.emp.vo.EmpVO;
import com.kpms.lgnhst.vo.LgnHstVO;

public interface EmpService {

	public boolean createOneEmp(EmpVO empVO, MultipartFile uploadFile);
	
	public boolean readPwdChngDtMore90ById(String empId);
	
	public EmpVO readOneEmpByIdAndPwd(EmpVO empVO);
	public EmpVO readOneEmpByEmpId(String empId);
	
	public List<EmpVO> readEmpListNoPagination(EmpVO empVO);
	public List<EmpVO> readEmpList(EmpVO empVO);
	
	public boolean updateOneEmp(EmpVO empVO, MultipartFile uploadFile);
	
	public boolean deleteOneEmp(EmpVO empVO);

	public boolean createLgnHst(LgnHstVO lgnHst);

	public boolean updateEmpPwd(EmpPwdVO empPwdVO);

	public boolean updateEmpPwdReset(EmpVO empVO);

}

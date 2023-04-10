package com.kpms.emp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.emp.dao.EmpDAO;
import com.kpms.emp.vo.EmpVO;

@Service
public class EmpServiceImpl implements EmpService {
	@Autowired
	private EmpDAO empDAO;

	@Override
	public boolean createOneEmp(EmpVO empVO) {
		return empDAO.createOneEmp(empVO) > 0;
	}

	@Override
	public EmpVO readOneEmpByIdAndPwd(EmpVO empVO) {
		return empDAO.readOneEmpByIdAndPwd(empVO);
	}

	@Override
	public EmpVO readOneEmpByEmpId(String empId) {
		return empDAO.readOneEmpByEmpId(empId);
	}

	@Override
	public List<EmpVO> readEmpList(EmpVO empVO) {
		return empDAO.readEmpList(empVO);
	}

	@Override
	public boolean updateOneEmp(EmpVO empVO) {
		return empDAO.updateOneEmp(empVO) > 0;
	}

	@Override
	public boolean deleteOneEmp(EmpVO empVO) {
		return empDAO.deleteOneEmp(empVO) > 0;
	}
}

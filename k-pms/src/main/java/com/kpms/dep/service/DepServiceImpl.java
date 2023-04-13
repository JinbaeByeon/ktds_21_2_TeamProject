package com.kpms.dep.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.common.exception.APIArgsException;
import com.kpms.common.exception.APIException;
import com.kpms.dep.dao.DepDAO;
import com.kpms.dep.vo.DepVO;
import com.kpms.emp.dao.EmpDAO;
import com.kpms.emp.vo.EmpVO;

@Service
public class DepServiceImpl implements DepService {

	@Autowired
	private DepDAO depDAO;
	
	@Autowired
	private EmpDAO empDAO;

	@Override
	public List<DepVO> readAllDepVO(DepVO depVO) {
		return depDAO.readAllDepVO(depVO);
	}
	
	@Override
	public List<DepVO> readAllDepVONopagination(String depNm) {
		return depDAO.readAllDepVONopagination(depNm);
	}
	
	@Override
	public DepVO readOneDepVOByDepId(String depId) {
		return depDAO.readOneDepVOByDepId(depId);
	}
	
	@Override
	public boolean createOneDep(DepVO depVO) {
		
//		int depCreateCount = depDAO.createOneDep(depVO);
//		if (depCreateCount > 0) {
//			
//			List<EmpVO> empList = depVO.getEmpList();
//			if (empList == null || empList.isEmpty()) {
//				throw new APIArgsException("404", "부서장을 선택하세요.");
//			}
//			for (EmpVO emp: empList) {
//				empDAO.createOneEmp(emp);
//			}
//		}
//		
//		return depCreateCount > 0;
		if (depVO.getDepNm() == null || depVO.getDepNm().trim().length() == 0) {
			throw new APIArgsException("400", "부서명이 누락되었습니다.");
		}
		return depDAO.createOneDep(depVO) > 0;
	}

	@Override
	public boolean updateOneDepByDepId(DepVO depVO) {
//		int depUpdateCount = depDAO.updateOneDepByDepId(depVO);
//		if (depUpdateCount > 0) {
//			
//			List<EmpVO> empList = depVO.getEmpList();
//			if (empList == null || empList.isEmpty()) {
//				throw new APIArgsException("404", "부서장을 선택하세요.");
//			}
//			for (EmpVO emp: empList) {
//				empDAO.createOneEmp(emp);
//			}
//		}
//		
//		return depUpdateCount > 0;
		if (depVO.getDepNm() == null || depVO.getDepNm().trim().length() == 0) {
			throw new APIArgsException("400", "부서명이 누락되었습니다.");
		}
		return depDAO.updateOneDepByDepId(depVO) > 0;
	}

	@Override
	public boolean deleteOneDepByDepId(String depId) {
		return depDAO.deleteOneDepByDepId(depId) > 0;
	}

	@Override
	public boolean deleteDepBySelectedDepId(List<String> depId) {
		
		int delCount = depDAO.deleteDepBySelectedDepId(depId);
		boolean isSuccess = delCount == depId.size();
		
		if (!isSuccess) {
			throw new APIException("500", "삭제에 실패했습니다. 요청건수:("+depId.size() +"건), 삭제건수:("+delCount+"건)");
		}
		
		return isSuccess; 
	}

	
}

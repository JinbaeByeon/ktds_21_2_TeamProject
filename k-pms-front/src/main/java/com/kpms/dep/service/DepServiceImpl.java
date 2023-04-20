package com.kpms.dep.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.common.exception.APIArgsException;
import com.kpms.common.exception.APIException;
import com.kpms.dep.dao.DepDAO;
import com.kpms.dep.vo.DepVO;
import com.kpms.dep.vo.DeptSearchVO;
import com.kpms.emp.dao.EmpDAO;
import com.kpms.emp.vo.EmpVO;

@Service
public class DepServiceImpl implements DepService {

	@Autowired
	private DepDAO depDAO;
	
	@Autowired
	private EmpDAO empDAO;

	@Override
	public List<DepVO> readAllDepVO(DeptSearchVO deptSearchVO) {
		return depDAO.readAllDepVO(deptSearchVO);
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
		

		if (depVO.getDepNm() == null || depVO.getDepNm().trim().length() == 0) {
			throw new APIArgsException("400", "부서명이 누락되었습니다.");
		}
		if (depVO.getDepHdId() == null || depVO.getDepHdId().trim().length() == 0) {
			throw new APIArgsException("400", "부서장이 누락되었습니다.");
		}
		if (depVO.getDepCrtDt() == null || depVO.getDepCrtDt().trim().length() == 0) {
			throw new APIArgsException("400", "부서생성일이 누락되었습니다.");
		}
		return depDAO.createOneDep(depVO) > 0;
	}

	@Override
	public boolean updateOneDepByDepId(DepVO depVO) {

		if (depVO.getDepNm() == null || depVO.getDepNm().trim().length() == 0) {
			throw new APIArgsException("400", "부서명이 누락되었습니다.");
		}
		if (depVO.getDepHdId() == null || depVO.getDepHdId().trim().length() == 0) {
			throw new APIArgsException("400", "부서장이 누락되었습니다.");
		}
		if (depVO.getDepCrtDt() == null || depVO.getDepCrtDt().trim().length() == 0) {
			throw new APIArgsException("400", "부서생성일이 누락되었습니다.");
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

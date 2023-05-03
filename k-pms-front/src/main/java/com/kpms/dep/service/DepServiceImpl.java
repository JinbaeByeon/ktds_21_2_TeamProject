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
import com.kpms.tm.dao.TmDAO;
import com.kpms.tmmbr.dao.TmMbrDAO;

@Service
public class DepServiceImpl implements DepService {

	@Autowired
	private DepDAO depDAO;
	
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
	public List<DepVO> readAllDepToTmMbr(DepVO depVO) {
		return depDAO.readAllDepToTmMbr(depVO);
	}

	
}

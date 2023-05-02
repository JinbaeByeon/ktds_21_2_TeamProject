package com.kpms.dep.service;

import java.util.List;

import com.kpms.dep.vo.DepVO;
import com.kpms.dep.vo.DeptSearchVO;

public interface DepService {

	public List<DepVO> readAllDepVO(DeptSearchVO deptSearchVO);
	
	public List<DepVO> readAllDepVONopagination(String depNm);
	
	public DepVO readOneDepVOByDepId(String depId);
	
	public boolean createOneDep(DepVO depVO);
	
	public boolean updateOneDepByDepId(DepVO depVO);
	
	public boolean deleteOneDepByDepId(String depId);
	
	public boolean deleteDepBySelectedDepId(List<String> depId);
	
	public List<DepVO> readAllDepToTmMbr(DeptSearchVO deptSearchVO);
	
}

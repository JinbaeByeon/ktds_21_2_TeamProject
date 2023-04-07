package com.kpms.dep.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.dep.dao.DepDAO;
import com.kpms.dep.vo.DepVO;

@Service
public class DepServiceImpl implements DepService {

	@Autowired
	private DepDAO depDAO;

	@Override
	public List<DepVO> readAllDepVO(DepVO depVO) {
		return depDAO.readAllDepVO(depVO);
	}
	
	@Override
	public List<DepVO> readAllDepVONopagination(String depHdNm) {
		return depDAO.readAllDepVONopagination(depHdNm);
	}
	
	@Override
	public boolean createOneDep(DepVO depVO) {
		return depDAO.createOneDep(depVO) > 0;
	}

	@Override
	public DepVO readOneDepVOByDepId(String depId) {
		return depDAO.readOneDepVOByDepId(depId);
	}

	@Override
	public boolean updateOneDepByDepId(DepVO depVO) {
		return depDAO.updateOneDepByDepId(depVO) > 0;
	}

	@Override
	public boolean deleteOneDepByDepId(String depId) {
		return depDAO.deleteOneDepByDepId(depId) > 0;
	}

	@Override
	public boolean deleteDepBySelectedDepId(List<String> depIdList) {
		return depDAO.deleteDepBySelectedDepId(depIdList) > 0;
	}

	
}

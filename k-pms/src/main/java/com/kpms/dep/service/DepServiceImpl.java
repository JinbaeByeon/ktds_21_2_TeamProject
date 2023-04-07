package com.kpms.dep.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.dep.dao.DepDAO;
import com.kpms.dep.vo.DepVO;

@Service
public class DepServiceImpl implements DepService {

	@Autowired
	private DepDAO depDAO;

	@Override
	public boolean createOneDep(DepVO depVO) {
		return depDAO.createOneDep(depVO) > 0;
	}
	
	
}

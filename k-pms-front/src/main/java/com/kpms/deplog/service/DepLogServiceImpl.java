package com.kpms.deplog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.deplog.dao.DepLogDAO;
import com.kpms.deplog.vo.DepLogVO;

@Service
public class DepLogServiceImpl implements DepLogService {

	@Autowired
	private DepLogDAO depLogDAO;
	
	@Override
	public List<DepLogVO> readAllDepLogVO(DepLogVO depLogVO) {
		return depLogDAO.readAllDepLogVO(depLogVO);
	}

}

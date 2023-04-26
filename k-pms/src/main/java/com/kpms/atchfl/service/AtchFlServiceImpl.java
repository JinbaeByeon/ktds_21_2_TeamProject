package com.kpms.atchfl.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.atchfl.dao.AtchFlDAO;
import com.kpms.atchfl.vo.AtchFlVO;

@Service
public class AtchFlServiceImpl implements AtchFlService {

	@Autowired
	private AtchFlDAO atchFlDAO;

	@Override
	public boolean createNewAtchFl(AtchFlVO atchFlVO) {
		return atchFlDAO.createNewAtchFl(atchFlVO) > 0;
	}
	
	
}

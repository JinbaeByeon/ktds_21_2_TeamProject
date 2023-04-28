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
	public boolean doCreateNewAtchFl(AtchFlVO atchFlVO) {
		return atchFlDAO.doCreateNewAtchFl(atchFlVO) > 0;
	}
	
	
}

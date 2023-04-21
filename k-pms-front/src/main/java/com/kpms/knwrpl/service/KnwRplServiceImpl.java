package com.kpms.knwrpl.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.knwrpl.dao.KnwRplDAO;
import com.kpms.knwrpl.vo.KnwRplVO;

@Service
public class KnwRplServiceImpl implements KnwRplService{
	@Autowired
	private KnwRplDAO knwRplDAO;

	@Override
	public boolean createNewKnwRpl(KnwRplVO knwRplVO) {
		return knwRplDAO.createNewKnwRpl(knwRplVO) > 0;
	}

	@Override
	public boolean updateOneKnwRpl(KnwRplVO knwRplVO) { 	
		return knwRplDAO.updateOneKnwRpl(knwRplVO) > 0;
	}

	@Override
	public boolean deleteOneKnwRpl(String rplId) {
		return knwRplDAO.deleteOneKnwRpl(rplId) > 0;
	}
}

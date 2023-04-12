package com.kpms.knw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.knw.dao.KnwDAO;
import com.kpms.knw.vo.KnwVO;

@Service
public class KnwServiceImpl implements KnwService {

	@Autowired
	private KnwDAO knwDAO;

	@Override
	public boolean createOneKnw(KnwVO knwVO) {
		return knwDAO.createOneKnw(knwVO) > 0;
	}

	@Override
	public List<KnwVO> readAllKnw(KnwVO knwVO) {
		return knwDAO.readAllKnw(knwVO);
	}
	
	
}

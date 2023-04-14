package com.kpms.lgnhst.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.lgnhst.dao.LgnHstDAO;
import com.kpms.lgnhst.vo.LgnHstVO;

@Service
public class LgnHstServiceImpl implements LgnHstService {

	@Autowired
	private LgnHstDAO lgnHstDAO;

	@Override
	public List<LgnHstVO> readAllLgnHst(LgnHstVO lgnHst) {
		return lgnHstDAO.readAllLgnHst(lgnHst);
	}

}

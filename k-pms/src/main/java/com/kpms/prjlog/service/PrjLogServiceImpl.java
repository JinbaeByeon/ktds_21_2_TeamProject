package com.kpms.prjlog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.prjlog.dao.PrjLogDAO;
import com.kpms.prjlog.vo.PrjLogVO;

@Service
public class PrjLogServiceImpl implements PrjLogService {
	
	@Autowired
	private PrjLogDAO prjLogDAO;

	@Override
	public List<PrjLogVO> readAllPrjLog(PrjLogVO prjLogVO) {
		return prjLogDAO.readAllPrjLog(prjLogVO);
	}
	
	
}

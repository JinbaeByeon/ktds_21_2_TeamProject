package com.kpms.pstnlog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.pstnlog.dao.PstnLogDAO;
import com.kpms.pstnlog.vo.PstnLogVO;

@Service
public class PstnLogServiceImpl implements PstnLogService{

	@Autowired
	private PstnLogDAO pstnLogDAO;
	
	@Override
	public List<PstnLogVO> readAllPstnLogVO(PstnLogVO pstnLogVO) {
		return pstnLogDAO.readAllPstnLogVO(pstnLogVO);
	}

}

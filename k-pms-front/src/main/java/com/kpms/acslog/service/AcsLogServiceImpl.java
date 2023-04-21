package com.kpms.acslog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.acslog.dao.AcsLogDAO;
import com.kpms.acslog.vo.AcsLogVO;

@Service
public class AcsLogServiceImpl implements AcsLogService {

	@Autowired
	private AcsLogDAO acsLogDAO;
	
	@Override
	public boolean createAcsLog(AcsLogVO acsLog) {
		return acsLogDAO.createAcsLog(acsLog) > 0;
	}

	@Override
	public List<AcsLogVO> readAllAcsLog(AcsLogVO acsLog) {
		return acsLogDAO.readAllAcsLog(acsLog);
	}

}

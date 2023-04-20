package com.kpms.eqplog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.eqplog.dao.EqpLogDAO;
import com.kpms.eqplog.vo.EqpLogVO;

@Service
public class EqpLogServiceImpl implements EqpLogService{

	@Autowired
	private EqpLogDAO eqpLogDAO;

	@Override
	public boolean createEqpLog(EqpLogVO eqpLogVO) {
		return eqpLogDAO.createEqpLog(eqpLogVO) > 0;
	}

	@Override
	public List<EqpLogVO> readAllEqpLog(EqpLogVO eqpLogVO) {
		return eqpLogDAO.readAllEqpLog(eqpLogVO);
	}
}

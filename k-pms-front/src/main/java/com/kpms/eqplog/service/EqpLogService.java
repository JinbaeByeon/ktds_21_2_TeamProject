package com.kpms.eqplog.service;

import java.util.List;

import com.kpms.eqplog.vo.EqpLogVO;

public interface EqpLogService {

	public boolean createEqpLog(EqpLogVO eqpLogVO);
	public List<EqpLogVO> readAllEqpLog(EqpLogVO eqpLogVO);
}

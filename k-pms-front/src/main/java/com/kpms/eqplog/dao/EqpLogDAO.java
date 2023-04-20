package com.kpms.eqplog.dao;

import java.util.List;

import com.kpms.eqplog.vo.EqpLogVO;

public interface EqpLogDAO {
	
	public int createEqpLog(EqpLogVO eqpLogVO);
	
	public List<EqpLogVO> readAllEqpLog(EqpLogVO eqpLogVO);
}

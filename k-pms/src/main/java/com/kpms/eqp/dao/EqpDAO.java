package com.kpms.eqp.dao;

import java.util.List;

import com.kpms.eqp.vo.EqpVO;

public interface EqpDAO {
	
	public int createNewEqp(EqpVO eqpVO);
	public List<EqpVO> readAllEqp(EqpVO eqpVO);
	public int updateEqp(EqpVO eqpVO);
	public int deleteEqpByEqpId(String eqpId);
	public int deleteEqpBySelectedEqpId(List<String> eqpId);
	
}

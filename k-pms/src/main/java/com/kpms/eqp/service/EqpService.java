package com.kpms.eqp.service;

import java.util.List;

import com.kpms.emp.vo.EmpVO;
import com.kpms.eqp.vo.EqpVO;

public interface EqpService {

	
	public boolean createNewEqp(EqpVO eqpVO);
	
	public List<EqpVO> readAllEqp(EqpVO eqpVO);
	
	public List<EqpVO> readAllEqpNoPagination(String eqpNm);
	public boolean applyEqp(List<String> eqpId, EmpVO empVO, String action);
	
	public boolean updateEqp(EqpVO eqpVO);

	public boolean deleteEqpByEqpId(String eqpId);
	public boolean deleteEqpBySelectedEqpId(List<String> eqpId);

}

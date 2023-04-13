package com.kpms.eqp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.eqp.dao.EqpDAO;
import com.kpms.eqp.vo.EqpVO;

@Service
public class EqpServiceImpl implements EqpService{
	
	@Autowired
	private EqpDAO eqpDAO;
	
	@Override
	public boolean createNewEqp(EqpVO eqpVO) {
		return eqpDAO.createNewEqp(eqpVO) > 0;
	}

	@Override
	public List<EqpVO> readAllEqp(EqpVO eqpVO) {
		return eqpDAO.readAllEqp(eqpVO);
	}

	@Override
	public List<EqpVO> readAllEqpNoPagination(String eqpNm) {
		return eqpDAO.readAllEqpNoPagination(eqpNm);
	}
	
	@Override
	public boolean updateEqp(EqpVO eqpVO) {
		return eqpDAO.updateEqp(eqpVO) > 0;
	}

	@Override
	public boolean deleteEqpByEqpId(String eqpId) {
		return eqpDAO.deleteEqpByEqpId(eqpId) > 0;
	}

	@Override
	public boolean deleteEqpBySelectedEqpId(List<String> eqpId) {
		return eqpDAO.deleteEqpBySelectedEqpId(eqpId) > 0;
	}

	

}

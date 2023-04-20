package com.kpms.eqp.dao;

import java.util.List;

import com.kpms.eqp.vo.EqpVO;

public interface EqpDAO {
	//비품 자체 CRUD
	public int createNewEqp(EqpVO eqpVO);
	
	public List<EqpVO> readAllEqp(EqpVO eqpVO);
	
	public List<EqpVO> readAllEqpNoPagination(String eqpNm);
	public List<EqpVO> readEqpByEqpId(List<String> eqpId);
	
	public int updateEqp(EqpVO eqpVO);
	public int applyEqp(EqpVO eqpVO);
	public int deleteEqpByEqpId(String eqpId);
	public int deleteEqpBySelectedEqpId(List<String> eqpId);
	
	//비품 대여 CRUD 
	// 대여신청(C)
	public int createNewRentEqp(EqpVO eqpVO);
	// 대여신청 현황(RUD)
	// 변경관리 --- 대여기록
	// 분실물 관리 (RUD)--
	// 
}

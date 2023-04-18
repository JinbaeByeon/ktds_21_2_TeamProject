package com.kpms.lgnhst.dao;

import java.util.List;

import com.kpms.lgnhst.vo.LgnHstVO;

public interface LgnHstDAO {
	
	public int createEmpLgnHst(LgnHstVO lgnHst);
	
	public List<LgnHstVO> readAllLgnHst(LgnHstVO lgnHst);
}

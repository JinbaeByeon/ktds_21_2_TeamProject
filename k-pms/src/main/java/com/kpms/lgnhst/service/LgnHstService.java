package com.kpms.lgnhst.service;

import java.util.List;

import com.kpms.lgnhst.vo.LgnHstExcelVO;
import com.kpms.lgnhst.vo.LgnHstVO;

public interface LgnHstService {

	public List<LgnHstVO> readAllLgnHst(LgnHstVO lgnHst);

	public List<LgnHstExcelVO> readAllLgnHstToExcel(LgnHstVO lgnHstVO);
}

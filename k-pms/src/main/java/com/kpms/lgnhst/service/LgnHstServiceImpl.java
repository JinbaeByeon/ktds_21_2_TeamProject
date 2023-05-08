package com.kpms.lgnhst.service;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.lgnhst.dao.LgnHstDAO;
import com.kpms.lgnhst.vo.LgnHstVO;

@Service
public class LgnHstServiceImpl implements LgnHstService {

	@Autowired
	private LgnHstDAO lgnHstDAO;

	@Override
	public List<LgnHstVO> readAllLgnHst(LgnHstVO lgnHst) {
		
		if (lgnHst.getStartDt() == null || lgnHst.getStartDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			
			String startDt = year + "-" + strMonth + "-" + strDay;
			lgnHst.setStartDt(startDt);
		}
		
		if (lgnHst.getEndDt() == null || lgnHst.getEndDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String endMonth = month < 10 ? "0" + month : month + "";
			String endDay = day < 10 ? "0" + day : day + "";
			
			String endDt = year + "-" + endMonth + "-" + endDay;
			lgnHst.setEndDt(endDt);
		}
		
		return lgnHstDAO.readAllLgnHst(lgnHst);
	}

}

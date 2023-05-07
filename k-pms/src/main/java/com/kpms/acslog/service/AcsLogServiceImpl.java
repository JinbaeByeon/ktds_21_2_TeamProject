package com.kpms.acslog.service;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.acslog.dao.AcsLogDAO;
import com.kpms.acslog.vo.AcsLogVO;

@Service
public class AcsLogServiceImpl implements AcsLogService {

	@Autowired
	private AcsLogDAO acsLogDAO;
	
	@Override
	public boolean createAcsLog(AcsLogVO acsLog) {
		return acsLogDAO.createAcsLog(acsLog) > 0;
	}

	@Override
	public List<AcsLogVO> readAllAcsLog(AcsLogVO acsLog) {
		
		if (acsLog.getStartDt() == null || acsLog.getStartDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			
			String startDt = year + "-" + strMonth + "-" + strDay;
			acsLog.setStartDt(startDt);
		}
		
		if (acsLog.getEndDt() == null || acsLog.getEndDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String endMonth = month < 10 ? "0" + month : month + "";
			String endDay = day < 10 ? "0" + day : day + "";
			
			String endDt = year + "-" + endMonth + "-" + endDay;
			acsLog.setEndDt(endDt);
		}
		
		return acsLogDAO.readAllAcsLog(acsLog);
	}

}

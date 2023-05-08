package com.kpms.pstnlog.service;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.pstnlog.dao.PstnLogDAO;
import com.kpms.pstnlog.vo.PstnLogVO;

@Service
public class PstnLogServiceImpl implements PstnLogService{

	@Autowired
	private PstnLogDAO pstnLogDAO;
	
	@Override
	public List<PstnLogVO> readAllPstnLogVO(PstnLogVO pstnLogVO) {
		
		if (pstnLogVO.getStartDt() == null || pstnLogVO.getStartDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			
			String startDt = year + "-" + strMonth + "-" + strDay;
			pstnLogVO.setStartDt(startDt);
		}
		
		if (pstnLogVO.getEndDt() == null || pstnLogVO.getEndDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String endMonth = month < 10 ? "0" + month : month + "";
			String endDay = day < 10 ? "0" + day : day + "";
			
			String endDt = year + "-" + endMonth + "-" + endDay;
			pstnLogVO.setEndDt(endDt);
		}
		
		return pstnLogDAO.readAllPstnLogVO(pstnLogVO);
	}

}

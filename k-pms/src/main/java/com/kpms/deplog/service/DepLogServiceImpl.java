package com.kpms.deplog.service;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.deplog.dao.DepLogDAO;
import com.kpms.deplog.vo.DepLogVO;

@Service
public class DepLogServiceImpl implements DepLogService {

	@Autowired
	private DepLogDAO depLogDAO;
	
	@Override
	public List<DepLogVO> readAllDepLogVO(DepLogVO depLogVO) {
		
		if (depLogVO.getStartDt() == null || depLogVO.getStartDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			
			String startDt = year + "-" + strMonth + "-" + strDay;
			depLogVO.setStartDt(startDt);
		}
		
		if (depLogVO.getEndDt() == null || depLogVO.getEndDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String endMonth = month < 10 ? "0" + month : month + "";
			String endDay = day < 10 ? "0" + day : day + "";
			
			String endDt = year + "-" + endMonth + "-" + endDay;
			depLogVO.setEndDt(endDt);
		}
		
		return depLogDAO.readAllDepLogVO(depLogVO);
	}

}

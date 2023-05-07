package com.kpms.joblog.service;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.joblog.dao.JobLogDAO;
import com.kpms.joblog.vo.JobLogVO;

@Service
public class JobLogServiceImpl implements JobLogService {

	@Autowired
	private JobLogDAO jobLogDAO;
	
	@Override
	public List<JobLogVO> readAllJobLogVO(JobLogVO jobLogVO) {
		
		if (jobLogVO.getStartDt() == null || jobLogVO.getStartDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String strMonth = month < 10 ? "0" + month : month + "";
			String strDay = day < 10 ? "0" + day : day + "";
			
			String startDt = year + "-" + strMonth + "-" + strDay;
			jobLogVO.setStartDt(startDt);
		}
		
		if (jobLogVO.getEndDt() == null || jobLogVO.getEndDt().length() == 0) {
			Calendar cal = Calendar.getInstance();
			
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String endMonth = month < 10 ? "0" + month : month + "";
			String endDay = day < 10 ? "0" + day : day + "";
			
			String endDt = year + "-" + endMonth + "-" + endDay;
			jobLogVO.setEndDt(endDt);
		}
		
		return jobLogDAO.readAllJobLogVO(jobLogVO);
	}

}

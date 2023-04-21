package com.kpms.joblog.service;

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
		return jobLogDAO.readAllJobLogVO(jobLogVO);
	}

}

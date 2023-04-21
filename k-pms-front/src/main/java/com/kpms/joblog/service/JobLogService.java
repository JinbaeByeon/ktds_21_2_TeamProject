package com.kpms.joblog.service;

import java.util.List;

import com.kpms.joblog.vo.JobLogVO;

public interface JobLogService {

	public List<JobLogVO> readAllJobLogVO(JobLogVO jobLogVO);
	
}

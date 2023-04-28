package com.kpms.joblog.dao;

import java.util.List;

import com.kpms.emp.vo.EmpChngJobVO;
import com.kpms.joblog.vo.JobLogVO;

public interface JobLogDAO {
	
	public List<JobLogVO> readAllJobLogVO(JobLogVO jobLogVO);
	
	public int createJobLog(EmpChngJobVO empChngJobVO);
}

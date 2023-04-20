package com.kpms.job.service;

import java.util.List;

import com.kpms.job.vo.JobVO;

public interface JobService {

	public List<JobVO>readAllJobVO(JobVO jobVO);
	public List<JobVO>readAllJobVONoPagination(String jobNm);
	public boolean createOneJob(JobVO jobVO);
	public boolean updateOneJob(JobVO jobVO);
	public boolean deleteOneJobByJobId(int jobId);
	public boolean deleteJobBySelectedJobId(List<Integer> jobId);
}

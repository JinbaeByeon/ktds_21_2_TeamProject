package com.kpms.job.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.job.dao.JobDAO;
import com.kpms.job.vo.JobVO;

@Service
public class JobServiceImpl implements JobService {
	
	@Autowired
	private JobDAO jobDAO;

	@Override
	public List<JobVO> readAllJobVO(JobVO jobVO) {
		return jobDAO.readAllJobVO(jobVO);
	}

	@Override
	public boolean createOneJob(JobVO jobVO) {
		return jobDAO.createOneJob(jobVO) > 0;
	}

	@Override
	public boolean updateOneJob(JobVO jobVO) {
		return jobDAO.updateOneJob(jobVO) > 0;
	}

	@Override
	public boolean deleteOneJobByJobId(int jobId) {
		return jobDAO.deleteOneJobByJobId(jobId) > 0;
	}
	
	

}

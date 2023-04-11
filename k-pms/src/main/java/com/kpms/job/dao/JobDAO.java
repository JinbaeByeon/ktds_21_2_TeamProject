package com.kpms.job.dao;

import java.util.List;

import com.kpms.job.vo.JobVO;

public interface JobDAO {
	
	// 조회
	public List<JobVO>readAllJobVO(JobVO jobVO);
	
	public List<JobVO>readAllJobVONoPagination(String jobNm);
	
	// 등록
	public int createOneJob(JobVO jobVO);
	
	// 수정
	public int updateOneJob(JobVO jobVO);
	
	// 삭제
	public int deleteOneJobByJobId(int jobId);

	public int deleteJobBySelectedJobId(List<Integer> jobId);
}

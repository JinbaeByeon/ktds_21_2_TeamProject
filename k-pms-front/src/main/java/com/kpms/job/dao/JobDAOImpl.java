package com.kpms.job.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.job.vo.JobVO;

@Repository
public class JobDAOImpl extends SqlSessionDaoSupport implements JobDAO {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<JobVO> readAllJobVO(JobVO jobVO) {
		return getSqlSession().selectList("Job.readAllJobVO", jobVO);
	}

	@Override
	public List<JobVO> readAllJobVONoPagination(String jobNm) {
		return getSqlSession().selectList("Job.readAllJobVONoPagination", jobNm);
	}
	
	@Override
	public int createOneJob(JobVO jobVO) {
		return getSqlSession().insert("Job.createOneJob", jobVO);
	}

	@Override
	public int updateOneJob(JobVO jobVO) {
		return getSqlSession().update("Job.updateOneJob", jobVO);
	}

	@Override
	public int deleteOneJobByJobId(int jobId) {
		return getSqlSession().update("Job.deleteOneJobByJobId", jobId);
	}


	@Override
	public int deleteJobBySelectedJobId(List<Integer> jobId) {
		return getSqlSession().update("Job.deleteJobBySelectedJobId", jobId);
	}
}

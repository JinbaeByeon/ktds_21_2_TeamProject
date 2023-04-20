package com.kpms.joblog.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.emp.vo.EmpChngJobVO;
import com.kpms.joblog.vo.JobLogVO;

@Repository
public class JobLogDAOImpl extends SqlSessionDaoSupport implements JobLogDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public List<JobLogVO> readAllJobLogVO(JobLogVO jobLogVO) {
		return getSqlSession().selectList("JobLog.readAllJobLogVO", jobLogVO);
	}
	
	@Override
	public int createJobLog(EmpChngJobVO empChngJobVO) {
		return getSqlSession().insert("JobLog.createJobLog", empChngJobVO);
	}

}

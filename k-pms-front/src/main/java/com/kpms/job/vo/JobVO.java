package com.kpms.job.vo;

import com.kpms.common.vo.AbstractPagingVO;

/**
 * JOB
 */
public class JobVO extends AbstractPagingVO{
	private int jobId;
	private String jobNm;

	public int getJobId() {
		return jobId;
	}

	public void setJobId(int jobId) {
		this.jobId = jobId;
	}

	public String getJobNm() {
		return jobNm;
	}

	public void setJobNm(String jobNm) {
		this.jobNm = jobNm;
	}

}
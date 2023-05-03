package com.kpms.prjlog.vo;

import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.emp.vo.EmpVO;
import com.kpms.job.vo.JobVO;

/**
 * JOB_LOG
 */
public class PrjLogVO extends AbstractPagingVO {

	private String logId;
	private String prjId;
	private String stts;
	
	public String getLogId() {
		return logId;
	}
	public void setLogId(String logId) {
		this.logId = logId;
	}

	public String getPrjId() {
		return prjId;
	}
	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}
	public String getStts() {
		return stts;
	}
	public void setStts(String stts) {
		this.stts = stts;
	}
	
	

}
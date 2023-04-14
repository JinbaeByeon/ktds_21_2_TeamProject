package com.kpms.acslog.vo;

import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.emp.vo.EmpVO;

/**
 * ACS_LOG
 */
public class AcsLogVO extends AbstractPagingVO {

	private String logId;
	private String acsLog;

	private EmpVO emp;

	public void setLogId(String logId) {
		this.logId = logId;
	}

	public String getLogId() {
		return this.logId;
	}

	public void setAcsLog(String acsLog) {
		this.acsLog = acsLog;
	}

	public String getAcsLog() {
		return this.acsLog;
	}

	public EmpVO getEmp() {
		return emp;
	}

	public void setEmp(EmpVO emp) {
		this.emp = emp;
	}

}
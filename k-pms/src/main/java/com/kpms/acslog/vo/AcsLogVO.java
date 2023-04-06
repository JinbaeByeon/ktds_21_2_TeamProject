package com.kpms.acslog.vo;

import com.kpms.common.vo.AbstractVO;

import com.kpms.common.vo.AbstractVO;

/**
 * ACS_LOG
 */
public class AcsLogVO extends AbstractVO {

	private String logId;
	private String acsLog;


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

}
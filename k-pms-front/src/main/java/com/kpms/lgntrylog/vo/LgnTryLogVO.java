package com.kpms.lgntrylog.vo;

import com.kpms.common.vo.AbstractVO;

/**
 * LGN_TRY_LOG
 */
public class LgnTryLogVO extends AbstractVO{
	
	private String lgnTryIp;
	private String logId;
	
	public void setLgnTryIp(String lgnTryIp) {
		this.lgnTryIp = lgnTryIp;
	}

	public String getLgnTryIp() {
		return this.lgnTryIp;
	}

	public String getLogId() {
		return logId;
	}

	public void setLogId(String logId) {
		this.logId = logId;
	}
	
}
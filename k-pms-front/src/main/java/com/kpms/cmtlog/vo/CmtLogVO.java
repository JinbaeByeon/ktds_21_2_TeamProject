package com.kpms.cmtlog.vo;

import com.kpms.common.vo.AbstractVO;

/**
 * CMT_LOG
 */
public class CmtLogVO extends AbstractVO {

	private String cmtLogId;
	private String cmtTime;


	public void setCmtLogId(String cmtLogId) {
		this.cmtLogId = cmtLogId;
	}

	public String getCmtLogId() {
		return this.cmtLogId;
	}

	public void setCmtTime(String cmtTime) {
		this.cmtTime = cmtTime;
	}

	public String getCmtTime() {
		return this.cmtTime;
	}

}
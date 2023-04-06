package com.kpms.lgntrylog.vo;

import com.kpms.common.vo.AbstractVO;

/**
 * LGN_TRY_LOG
 */
public class LgnTryLogVO extends AbstractVO{

	private String lgnTryIp;
	private int lgnTryCnt;
	private String ltstLgnTryDt;


	public void setLgnTryIp(String lgnTryIp) {
		this.lgnTryIp = lgnTryIp;
	}

	public String getLgnTryIp() {
		return this.lgnTryIp;
	}

	public void setLgnTryCnt(int lgnTryCnt) {
		this.lgnTryCnt = lgnTryCnt;
	}

	public int getLgnTryCnt() {
		return this.lgnTryCnt;
	}

	public void setLtstLgnTryDt(String ltstLgnTryDt) {
		this.ltstLgnTryDt = ltstLgnTryDt;
	}

	public String getLtstLgnTryDt() {
		return this.ltstLgnTryDt;
	}

}
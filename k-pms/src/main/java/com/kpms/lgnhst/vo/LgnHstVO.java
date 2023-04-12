package com.kpms.lgnhst.vo;

import com.kpms.common.vo.AbstractVO;

/**
 * LGN_HST
 */
public class LgnHstVO extends AbstractVO{
	
	private String hstId;
	private String ip;
	private String act;

	public void setHstId(String hstId) {
		this.hstId = hstId;
	}

	public String getHstId() {
		return this.hstId;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getIp() {
		return this.ip;
	}

	public void setAct(String act) {
		this.act = act;
	}

	public String getAct() {
		return this.act;
	}

}
package com.kpms.knwrpl.vo;

import com.kpms.common.vo.AbstractVO;

/**
 * KNW_RPL
 */
public class KnwRplVO extends AbstractVO {

	private int depth;

	private String rplId;
	private String cnt;
	private String knwId;
	private String prcdncRplId;

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public String getRplId() {
		return rplId;
	}

	public void setRplId(String rplId) {
		this.rplId = rplId;
	}

	public String getCnt() {
		return cnt;
	}

	public void setCnt(String cnt) {
		this.cnt = cnt;
	}

	public String getKnwId() {
		return knwId;
	}

	public void setKnwId(String knwId) {
		this.knwId = knwId;
	}

	public String getPrcdncRplId() {
		return prcdncRplId;
	}

	public void setPrcdncRplId(String prcdncRplId) {
		this.prcdncRplId = prcdncRplId;
	}

}
package com.kpms.atchfl.vo;

import com.kpms.common.vo.AbstractVO;

public class AtchFlVO extends AbstractVO{

	private String frgnId;
	private String orgFlNm;
	private String uuidFlNm;
	private long flSz;
	private String flExt;

	public String getFrgnId() {
		return frgnId;
	}

	public void setFrgnId(String frgnId) {
		this.frgnId = frgnId;
	}

	public String getOrgFlNm() {
		return orgFlNm;
	}

	public void setOrgFlNm(String orgFlNm) {
		this.orgFlNm = orgFlNm;
	}

	public String getUuidFlNm() {
		return uuidFlNm;
	}

	public void setUuidFlNm(String uuidFlNm) {
		this.uuidFlNm = uuidFlNm;
	}

	public long getFlSz() {
		return flSz;
	}

	public void setFlSz(long flSz) {
		this.flSz = flSz;
	}

	public String getFlExt() {
		return flExt;
	}

	public void setFlExt(String flExt) {
		this.flExt = flExt;
	}

}

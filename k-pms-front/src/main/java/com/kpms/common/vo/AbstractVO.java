package com.kpms.common.vo;

public abstract class AbstractVO {
	
	private String crtDt;
	private String crtr;
	private String mdfyDt;
	private String mdfyr;
	private String useYn;
	private String delYn;
	
	public String getCrtDt() {
		return crtDt;
	}
	public void setCrtDt(String crtDt) {
		this.crtDt = crtDt;
	}
	public String getCrtr() {
		return crtr;
	}
	public void setCrtr(String crtr) {
		this.crtr = crtr;
	}
	public String getMdfyDt() {
		return mdfyDt;
	}
	public void setMdfyDt(String mdfyDt) {
		this.mdfyDt = mdfyDt;
	}
	public String getMdfyr() {
		return mdfyr;
	}
	public void setMdfyr(String mdfyr) {
		this.mdfyr = mdfyr;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
}

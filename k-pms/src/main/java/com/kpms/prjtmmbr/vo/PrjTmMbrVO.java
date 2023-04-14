package com.kpms.prjtmmbr.vo;

import com.kpms.tmmbr.vo.TmMbrVO;

/**
 * PRJ_TM_MBR
 */
public class PrjTmMbrVO {

	private String prjTmMbrId;
	private String prjPstn;
	private String prjId;
	private String tmMbrId;
	
	private TmMbrVO tmMbrVO;
	
	public TmMbrVO getTmMbrVO() {
		return tmMbrVO;
	}

	public void setTmMbrVO(TmMbrVO tmMbrVO) {
		this.tmMbrVO = tmMbrVO;
	}

	public String getPrjTmMbrId() {
		return prjTmMbrId;
	}

	public void setPrjTmMbrId(String prjTmMbrId) {
		this.prjTmMbrId = prjTmMbrId;
	}

	public String getPrjPstn() {
		return prjPstn;
	}

	public void setPrjPstn(String prjPstn) {
		this.prjPstn = prjPstn;
	}

	public String getPrjId() {
		return prjId;
	}

	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}

	public String getTmMbrId() {
		return tmMbrId;
	}

	public void setTmMbrId(String tmMbrId) {
		this.tmMbrId = tmMbrId;
	}

}
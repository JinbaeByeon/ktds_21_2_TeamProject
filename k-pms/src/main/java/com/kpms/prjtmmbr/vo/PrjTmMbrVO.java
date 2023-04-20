package com.kpms.prjtmmbr.vo;

import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.tmmbr.vo.TmMbrVO;

/**
 * PRJ_TM_MBR
 */
public class PrjTmMbrVO extends AbstractPagingVO{

	private String prjTmMbrId;
	private String prjPstn;
	private String prjId;
	private String tmMbrId;
	
	private String added;
	private String deleted;
	private String modified;
	
	public String getAdded() {
		return added;
	}

	public void setAdded(String added) {
		this.added = added;
	}

	public String getModified() {
		return modified;
	}

	public void setModified(String modified) {
		this.modified = modified;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

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
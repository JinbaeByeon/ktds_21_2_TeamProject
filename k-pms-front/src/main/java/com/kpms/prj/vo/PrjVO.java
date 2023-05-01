package com.kpms.prj.vo;

import java.util.List;

import com.kpms.cmncd.vo.CmnCdVO;
import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.knw.vo.KnwVO;
import com.kpms.prjtmmbr.vo.PrjTmMbrVO;
import com.kpms.req.vo.ReqVO;

/**
 * PRJ
 */
public class PrjVO extends AbstractPagingVO{

	private String prjId;
	private String prjNm;
	private String cstmr;
	private String strtDt;
	private String endDt;
	private String prjStts;
	
	private List<PrjTmMbrVO> ptmList;
	private List<ReqVO> reqList;
	private List<KnwVO> knwList;


	public List<PrjTmMbrVO> getPtmList() {
		return ptmList;
	}

	public void setPtmList(List<PrjTmMbrVO> ptmList) {
		this.ptmList = ptmList;
	}

	public List<ReqVO> getReqList() {
		return reqList;
	}

	public void setReqList(List<ReqVO> reqList) {
		this.reqList = reqList;
	}

	public List<KnwVO> getKnwList() {
		return knwList;
	}

	public void setKnwList(List<KnwVO> knwList) {
		this.knwList = knwList;
	}

	public List<PrjTmMbrVO> getPrjTmMbrVO() {
		return ptmList;
	}

	public void setPrjTmMbrVO(List<PrjTmMbrVO> prjTmMbrVO) {
		ptmList = prjTmMbrVO;
	}

	public String getPrjId() {
		return prjId;
	}

	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}

	public String getPrjNm() {
		return prjNm;
	}

	public void setPrjNm(String prjNm) {
		this.prjNm = prjNm;
	}

	public String getCstmr() {
		return cstmr;
	}

	public void setCstmr(String cstmr) {
		this.cstmr = cstmr;
	}

	public String getStrtDt() {
		return strtDt;
	}

	public void setStrtDt(String strtDt) {
		this.strtDt = strtDt;
	}

	public String getEndDt() {
		return endDt;
	}

	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}

	public String getPrjStts() {
		return prjStts;
	}

	public void setPrjStts(String prjStts) {
		this.prjStts = prjStts;
	}

}
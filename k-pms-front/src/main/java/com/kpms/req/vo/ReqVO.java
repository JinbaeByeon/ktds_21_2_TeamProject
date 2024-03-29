package com.kpms.req.vo;

import java.util.List;

import com.kpms.atchfl.vo.AtchFlVO;
import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.prj.vo.PrjVO;
import com.kpms.reqcnfr.vo.ReqCnfrVO;
import com.kpms.reqtstr.vo.ReqTstrVO;
import com.kpms.tmmbr.vo.TmMbrVO;

/**
 * REQ
 */
public class ReqVO extends AbstractPagingVO {

	private String searchMode;
	private String selectOption;
	/**
	 * 요구사항ID
	 */
	private String reqId;
	/**
	 * 상세요구사항
	 */
	private String dtlReq;
	/**
	 * 시작일
	 */
	private String strtDt;
	/**
	 * 종료예정일
	 */
	private String expctEndDt;
	/**
	 * 첨부파일
	 */
	private String attch;
	/**
	 * 프로젝트ID
	 */
	private String prjId;
	/**
	 * 담당개발자
	 */
	private String mnDvlpr;
	/**
	 * 테스트결과
	 */
	private String tstRslt;
	/**
	 * 일정상태
	 */
	private String tskStts;
	/**
	 * 요구사항 진행상태
	 */
	private String prcsStts;
	/**
	 * 우선순위
	 */
	private String prrty;
	/**
	 * 요구사항 제목
	 */
	private String reqCnfrNm;
	private String reqTtl;
	
	
	private String rsltCdNm;
	private String tskCdNm;
	private String prcsCdNm;

	private TmMbrVO tmMbrVO;
	private PrjVO reqPrjVO;
	private ReqCnfrVO reqCnfVO;
	private ReqTstrVO reqTstVO;
	
	
	private List<AtchFlVO> atchFlList;
	
	
	public String getSelectOption() {
		return selectOption;
	}
	public void setSelectOption(String selectOption) {
		this.selectOption = selectOption;
	}
	public List<AtchFlVO> getAtchFlList() {
		return atchFlList;
	}
	public void setAtchFlList(List<AtchFlVO> atchFlList) {
		this.atchFlList = atchFlList;
	}
	public String getRsltCdNm() {
		return rsltCdNm;
	}
	public void setRsltCdNm(String rsltCdNm) {
		this.rsltCdNm = rsltCdNm;
	}
	public String getTskCdNm() {
		return tskCdNm;
	}
	public void setTskCdNm(String tskCdNm) {
		this.tskCdNm = tskCdNm;
	}
	public String getPrcsCdNm() {
		return prcsCdNm;
	}
	public void setPrcsCdNm(String prcsCdNm) {
		this.prcsCdNm = prcsCdNm;
	}
	public TmMbrVO getTmMbrVO() {
		return tmMbrVO;
	}
	public void setTmMbrVO(TmMbrVO tmMbrVO) {
		this.tmMbrVO = tmMbrVO;
	}
	public String getSearchMode() {
		return searchMode;
	}
	public void setSearchMode(String searchMode) {
		this.searchMode = searchMode;
	}
	public String getReqCnfrNm() {
		return reqCnfrNm;
	}
	public void setReqCnfrNm(String reqCnfrNm) {
		this.reqCnfrNm = reqCnfrNm;
	}
	public PrjVO getReqPrjVO() {
		return reqPrjVO;
	}
	public void setReqPrjVO(PrjVO reqPrjVO) {
		this.reqPrjVO = reqPrjVO;
	}
	public ReqCnfrVO getReqCnfVO() {
		return reqCnfVO;
	}
	public void setReqCnfVO(ReqCnfrVO reqCnfVO) {
		this.reqCnfVO = reqCnfVO;
	}
	public ReqTstrVO getReqTstVO() {
		return reqTstVO;
	}
	public void setReqTstVO(ReqTstrVO reqTstVO) {
		this.reqTstVO = reqTstVO;
	}
	public String getReqId() {
		return reqId;
	}
	public void setReqId(String reqId) {
		this.reqId = reqId;
	}
	public String getReqTtl() {
		return reqTtl;
	}
	public void setReqTtl(String reqTtl) {
		this.reqTtl = reqTtl;
	}
	public String getDtlReq() {
		return dtlReq;
	}
	public void setDtlReq(String dtlReq) {
		this.dtlReq = dtlReq;
	}
	public String getStrtDt() {
		return strtDt;
	}
	public void setStrtDt(String strtDt) {
		this.strtDt = strtDt;
	}
	public String getExpctEndDt() {
		return expctEndDt;
	}
	public void setExpctEndDt(String expctEndDt) {
		this.expctEndDt = expctEndDt;
	}
	public String getAttch() {
		return attch;
	}
	public void setAttch(String attch) {
		this.attch = attch;
	}
	public String getPrjId() {
		return prjId;
	}
	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}
	public String getMnDvlpr() {
		return mnDvlpr;
	}
	public void setMnDvlpr(String mnDvlpr) {
		this.mnDvlpr = mnDvlpr;
	}
	public String getTstRslt() {
		return tstRslt;
	}
	public void setTstRslt(String tstRslt) {
		this.tstRslt = tstRslt;
	}
	public String getTskStts() {
		return tskStts;
	}
	public void setTskStts(String tskStts) {
		this.tskStts = tskStts;
	}
	public String getPrcsStts() {
		return prcsStts;
	}
	public void setPrcsStts(String prcsStts) {
		this.prcsStts = prcsStts;
	}
	public String getPrrty() {
		return prrty;
	}
	public void setPrrty(String prrty) {
		this.prrty = prrty;
	}

}
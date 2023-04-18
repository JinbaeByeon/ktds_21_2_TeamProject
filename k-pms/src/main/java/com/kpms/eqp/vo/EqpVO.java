package com.kpms.eqp.vo;

import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.emp.vo.EmpVO;

/**
 * EQP
 */
public class EqpVO extends AbstractPagingVO {

	private String eqpId;
	private String eqpNm;
	private String eqpTp;
	private String applStts;
	private String applId;
	private String eqpPrc;
	private String prchsDt;
	private String lossStts;
	private String lossRprtDt;
	private String applDt;

	private String searchMode;

	private EmpVO crtrEmpVO;
	private EmpVO mdfyrEmpVO;
	
	
	
	public EmpVO getCrtrEmpVO() {
		return crtrEmpVO;
	}

	public void setCrtrEmpVO(EmpVO crtrEmpVO) {
		this.crtrEmpVO = crtrEmpVO;
	}

	public EmpVO getMdfyrEmpVO() {
		return mdfyrEmpVO;
	}

	public void setMdfyrEmpVO(EmpVO mdfyrEmpVO) {
		this.mdfyrEmpVO = mdfyrEmpVO;
	}

	public String getApplId() {
		return applId;
	}

	public void setApplId(String applId) {
		this.applId = applId;
	}

	public void setEqpId(String eqpId) {
		this.eqpId = eqpId;
	}

	public String getEqpId() {
		return this.eqpId;
	}

	public void setEqpNm(String eqpNm) {
		this.eqpNm = eqpNm;
	}

	public String getEqpNm() {
		return this.eqpNm;
	}

	public void setEqpTp(String eqpTp) {
		this.eqpTp = eqpTp;
	}

	public String getEqpTp() {
		return this.eqpTp;
	}

	public void setApplStts(String applStts) {
		this.applStts = applStts;
	}

	public String getApplStts() {
		return this.applStts;
	}

	public void setEqpPrc(String eqpPrc) {
		this.eqpPrc = eqpPrc;
	}

	public String getEqpPrc() {
		return this.eqpPrc;
	}

	public void setPrchsDt(String prchsDt) {
		this.prchsDt = prchsDt;
	}

	public String getPrchsDt() {
		return this.prchsDt;
	}

	public void setLossStts(String lossStts) {
		this.lossStts = lossStts;
	}

	public String getLossStts() {
		return this.lossStts;
	}

	public void setLossRprtDt(String lossRprtDt) {
		this.lossRprtDt = lossRprtDt;
	}

	public String getLossRprtDt() {
		return this.lossRprtDt;
	}

	public void setApplDt(String applDt) {
		this.applDt = applDt;
	}

	public String getApplDt() {
		return this.applDt;
	}

	public String getSearchMode() {
		return searchMode;
	}

	public void setSearchMode(String searchMode) {
		this.searchMode = searchMode;
	}

}
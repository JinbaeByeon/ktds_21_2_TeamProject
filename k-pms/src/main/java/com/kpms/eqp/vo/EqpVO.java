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

	public String getEqpId() {
		return eqpId;
	}

	public void setEqpId(String eqpId) {
		this.eqpId = eqpId;
	}

	public String getEqpNm() {
		return eqpNm;
	}

	public void setEqpNm(String eqpNm) {
		this.eqpNm = eqpNm;
	}

	public String getEqpTp() {
		return eqpTp;
	}

	public void setEqpTp(String eqpTp) {
		this.eqpTp = eqpTp;
	}

	public String getApplStts() {
		return applStts;
	}

	public void setApplStts(String applStts) {
		this.applStts = applStts;
	}

	public String getApplId() {
		return applId;
	}

	public void setApplId(String applId) {
		this.applId = applId;
	}

	public String getEqpPrc() {
		return eqpPrc;
	}

	public void setEqpPrc(String eqpPrc) {
		this.eqpPrc = eqpPrc;
	}

	public String getPrchsDt() {
		return prchsDt;
	}

	public void setPrchsDt(String prchsDt) {
		this.prchsDt = prchsDt;
	}

	public String getLossStts() {
		return lossStts;
	}

	public void setLossStts(String lossStts) {
		this.lossStts = lossStts;
	}

	public String getLossRprtDt() {
		return lossRprtDt;
	}

	public void setLossRprtDt(String lossRprtDt) {
		this.lossRprtDt = lossRprtDt;
	}

	public String getApplDt() {
		return applDt;
	}

	public void setApplDt(String applDt) {
		this.applDt = applDt;
	}

	public String getSearchMode() {
		return searchMode;
	}

	public void setSearchMode(String searchMode) {
		this.searchMode = searchMode;
	}

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

}
package com.kpms.eqplog.vo;

import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.emp.vo.EmpVO;

/**
 * EQP_LOG
 */
public class EqpLogVO extends AbstractPagingVO {

	private String logId;
	private String empId;
	private String eqpId;
	private String stts;

	private EmpVO crtrEmpVO;
	
	
	
	public EmpVO getCrtrEmpVO() {
		return crtrEmpVO;
	}

	public void setCrtrEmpVO(EmpVO crtrEmpVO) {
		this.crtrEmpVO = crtrEmpVO;
	}


	public void setLogId(String logId) {
		this.logId = logId;
	}

	public String getLogId() {
		return this.logId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getEmpId() {
		return this.empId;
	}

	public void setEqpId(String eqpId) {
		this.eqpId = eqpId;
	}

	public String getEqpId() {
		return this.eqpId;
	}

	public void setStts(String stts) {
		this.stts = stts;
	}

	public String getStts() {
		return this.stts;
	}

}
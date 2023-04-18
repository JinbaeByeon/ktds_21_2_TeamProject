package com.kpms.lgnhst.vo;

import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.emp.vo.EmpVO;

/**
 * LGN_HST
 */
public class LgnHstVO extends AbstractPagingVO{
	
	private String hstId;
	private String ip;
	private String act;
	
	private EmpVO emp;
	
	public void setHstId(String hstId) {
		this.hstId = hstId;
	}

	public String getHstId() {
		return this.hstId;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getIp() {
		return this.ip;
	}

	public void setAct(String act) {
		this.act = act;
	}

	public String getAct() {
		return this.act;
	}

	public EmpVO getEmp() {
		return emp;
	}

	public void setEmp(EmpVO emp) {
		this.emp = emp;
	}

}
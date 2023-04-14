package com.kpms.tmmbr.vo;

import com.kpms.common.vo.AbstractVO;
import com.kpms.emp.vo.EmpVO;

/**
 * TM_MBR
 */
public class TmMbrVO extends AbstractVO {

	private String tmMbrId;
	private String tmId;
	private String empId;
	
	private EmpVO empVO;
	
	public EmpVO getEmpVO() {
		return empVO;
	}
	public void setEmpVO(EmpVO empVO) {
		this.empVO = empVO;
	}
	public String getTmMbrId() {
		return tmMbrId;
	}
	public void setTmMbrId(String tmMbrId) {
		this.tmMbrId = tmMbrId;
	}
	public String getTmId() {
		return tmId;
	}
	public void setTmId(String tmId) {
		this.tmId = tmId;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}

}
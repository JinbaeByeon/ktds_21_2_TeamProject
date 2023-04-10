package com.kpms.dep.vo;

import java.util.List;

import com.kpms.common.vo.AbstractVO;
import com.kpms.emp.vo.EmpVO;

/**
 * DEP
 */
public class DepVO extends AbstractVO {

	private String depId;
	private String depNm;
	private String depHdNm;
	private String depHdId;
	private String depCrtDt;
	
	private List<EmpVO> empList;
	
	
	public String getDepId() {
		return depId;
	}
	public void setDepId(String depId) {
		this.depId = depId;
	}
	
	public String getDepNm() {
		return depNm;
	}
	public void setDepNm(String depNm) {
		this.depNm = depNm;
	}
	
	public String getDepHdNm() {
		return depHdNm;
	}
	public void setDepHdNm(String depHdNm) {
		this.depHdNm = depHdNm;
	}
	public String getDepHdId() {
		return depHdId;
	}
	public void setDepHdId(String depHdId) {
		this.depHdId = depHdId;
	}
	public String getDepCrtDt() {
		return depCrtDt;
	}
	public void setDepCrtDt(String depCrtDt) {
		this.depCrtDt = depCrtDt;
	}
	public List<EmpVO> getEmpList() {
		return empList;
	}
	public void setEmpList(List<EmpVO> empList) {
		this.empList = empList;
	}
	
	
	
}
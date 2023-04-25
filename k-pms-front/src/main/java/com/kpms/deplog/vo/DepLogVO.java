package com.kpms.deplog.vo;

import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.dep.vo.DepVO;
import com.kpms.emp.vo.EmpVO;

/**
 * DEP_LOG
 */
public class DepLogVO extends AbstractPagingVO {
	private String empId;
	private String chngDt;
	private String prvsDepId;
	private String chngDepId;
	private String chngRsn;

	private EmpVO empVO;
	private DepVO prvsDepNmVO;
	private DepVO chngDepNmVO;

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getEmpId() {
		return this.empId;
	}

	public void setChngDt(String chngDt) {
		this.chngDt = chngDt;
	}

	public String getChngDt() {
		return this.chngDt;
	}

	public void setPrvsDepId(String prvsDepId) {
		this.prvsDepId = prvsDepId;
	}

	public String getPrvsDepId() {
		return this.prvsDepId;
	}

	public void setChngDepId(String chngDepId) {
		this.chngDepId = chngDepId;
	}

	public String getChngDepId() {
		return this.chngDepId;
	}

	public void setChngRsn(String chngRsn) {
		this.chngRsn = chngRsn;
	}

	public String getChngRsn() {
		return this.chngRsn;
	}

	public EmpVO getEmpVO() {
		return empVO;
	}

	public void setEmpVO(EmpVO empVO) {
		this.empVO = empVO;
	}

	public DepVO getPrvsDepNmVO() {
		return prvsDepNmVO;
	}

	public void setPrvsDepNmVO(DepVO prvsDepNmVO) {
		this.prvsDepNmVO = prvsDepNmVO;
	}

	public DepVO getChngDepNmVO() {
		return chngDepNmVO;
	}

	public void setChngDepNmVO(DepVO chngDepNmVO) {
		this.chngDepNmVO = chngDepNmVO;
	}

}
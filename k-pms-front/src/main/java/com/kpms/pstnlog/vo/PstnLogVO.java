package com.kpms.pstnlog.vo;

import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.emp.vo.EmpVO;
import com.kpms.pstn.vo.PstnVO;

/**
 * PSTN_LOG
 */
public class PstnLogVO extends AbstractPagingVO {

	private String empId;
	private String chngDt;
	private String prvsPstnId;
	private String chngPstnId;
	private String chngRsn;
	
	private EmpVO empVO;
	private PstnVO prvsPstnNmVO;
	private PstnVO chngPstnNmVO;
	
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getChngDt() {
		return chngDt;
	}
	public void setChngDt(String chngDt) {
		this.chngDt = chngDt;
	}
	public String getPrvsPstnId() {
		return prvsPstnId;
	}
	public void setPrvsPstnId(String prvsPstnId) {
		this.prvsPstnId = prvsPstnId;
	}
	public String getChngPstnId() {
		return chngPstnId;
	}
	public void setChngPstnId(String chngPstnId) {
		this.chngPstnId = chngPstnId;
	}
	public String getChngRsn() {
		return chngRsn;
	}
	public void setChngRsn(String chngRsn) {
		this.chngRsn = chngRsn;
	}
	public EmpVO getEmpVO() {
		return empVO;
	}
	public void setEmpVO(EmpVO empVO) {
		this.empVO = empVO;
	}
	public PstnVO getPrvsPstnNmVO() {
		return prvsPstnNmVO;
	}
	public void setPrvsPstnNmVO(PstnVO prvsPstnNmVO) {
		this.prvsPstnNmVO = prvsPstnNmVO;
	}
	public PstnVO getChngPstnNmVO() {
		return chngPstnNmVO;
	}
	public void setChngPstnNmVO(PstnVO chngPstnNmVO) {
		this.chngPstnNmVO = chngPstnNmVO;
	}
	

}
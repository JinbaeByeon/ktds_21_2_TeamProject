package com.kpms.joblog.vo;

import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.emp.vo.EmpVO;
import com.kpms.job.vo.JobVO;

/**
 * JOB_LOG
 */
public class JobLogVO extends AbstractPagingVO {

	private String empId;
	private String chngDt;
	private String prvsJobId;
	private String chngJobId;
	private String chngRsn;
	
	private EmpVO empVO;
	private JobVO prvsJobNmVO;
	private JobVO chngJobNmVO;

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

	public String getPrvsJobId() {
		return prvsJobId;
	}

	public void setPrvsJobId(String prvsJobId) {
		this.prvsJobId = prvsJobId;
	}

	public String getChngJobId() {
		return chngJobId;
	}

	public void setChngJobId(String chngJobId) {
		this.chngJobId = chngJobId;
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

	public JobVO getPrvsJobNmVO() {
		return prvsJobNmVO;
	}

	public void setPrvsJobNmVO(JobVO prvsJobNmVO) {
		this.prvsJobNmVO = prvsJobNmVO;
	}

	public JobVO getChngJobNmVO() {
		return chngJobNmVO;
	}

	public void setChngJobNmVO(JobVO chngJobNmVO) {
		this.chngJobNmVO = chngJobNmVO;
	}

}
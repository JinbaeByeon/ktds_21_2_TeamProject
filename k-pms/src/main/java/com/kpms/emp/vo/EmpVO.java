package com.kpms.emp.vo;

import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.dep.vo.DepVO;
import com.kpms.job.vo.JobVO;
import com.kpms.pstn.vo.PstnVO;

/**
 * EMP
 */
public class EmpVO extends AbstractPagingVO{
	private String empId;
	private String fNm;
	private String brthdy;
	private String eml;
	private String phn;
	private int pstnPrd;
	private String prflPht;
	private String hrDt;
	private int hrPrd;
	private String pstCd;
	private String addrss;
	private String dtlAddrss;
	private String emplmntStts;
	private String admnYn;
	private String pwdChngDt;
	private String ltstLgnIp;
	private String ltstLgnDt;
	private String pwdSalt;
	private String pwd;
	private int pstnId;
	private int jobId;
	private String depId;
	private String lNm;
	private int lgnCnt;
	private String failDt;
	
	private EmpVO crtEmp;
	private EmpVO mdfyEmp;
	private DepVO dep;
	private JobVO job;
	private PstnVO pstn;
	
	
	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getlNm() {
		return lNm;
	}

	public void setlNm(String lNm) {
		this.lNm = lNm;
	}

	public String getfNm() {
		return fNm;
	}

	public void setfNm(String fNm) {
		this.fNm = fNm;
	}

	public void setBrthdy(String brthdy) {
		this.brthdy = brthdy;
	}

	public String getBrthdy() {
		return this.brthdy;
	}

	public void setEml(String eml) {
		this.eml = eml;
	}

	public String getEml() {
		return this.eml;
	}

	public void setPhn(String phn) {
		this.phn = phn;
	}

	public String getPhn() {
		return this.phn;
	}

	public void setPstnPrd(int pstnPrd) {
		this.pstnPrd = pstnPrd;
	}

	public int getPstnPrd() {
		return this.pstnPrd;
	}

	public void setPrflPht(String prflPht) {
		this.prflPht = prflPht;
	}

	public String getPrflPht() {
		return this.prflPht;
	}

	public void setHrDt(String hrDt) {
		this.hrDt = hrDt;
	}

	public String getHrDt() {
		return this.hrDt;
	}

	public void setHrPrd(int hrPrd) {
		this.hrPrd = hrPrd;
	}

	public int getHrPrd() {
		return this.hrPrd;
	}

	public String getPstCd() {
		return pstCd;
	}

	public void setPstCd(String pstCd) {
		this.pstCd = pstCd;
	}

	public void setAddrss(String addrss) {
		this.addrss = addrss;
	}

	public String getAddrss() {
		return this.addrss;
	}

	public String getDtlAddrss() {
		return dtlAddrss;
	}

	public void setDtlAddrss(String dtlAddrss) {
		this.dtlAddrss = dtlAddrss;
	}
	
	public void setEmplmntStts(String emplmntStts) {
		this.emplmntStts = emplmntStts;
	}

	public String getEmplmntStts() {
		return this.emplmntStts;
	}

	public void setAdmnYn(String admnYn) {
		this.admnYn = admnYn;
	}

	public String getAdmnYn() {
		return this.admnYn;
	}

	public void setPwdChngDt(String pwdChngDt) {
		this.pwdChngDt = pwdChngDt;
	}

	public String getPwdChngDt() {
		return this.pwdChngDt;
	}

	public void setLtstLgnIp(String ltstLgnIp) {
		this.ltstLgnIp = ltstLgnIp;
	}

	public String getLtstLgnIp() {
		return this.ltstLgnIp;
	}

	public void setLtstLgnDt(String ltstLgnDt) {
		this.ltstLgnDt = ltstLgnDt;
	}

	public String getLtstLgnDt() {
		return this.ltstLgnDt;
	}

	public void setPwdSalt(String pwdSalt) {
		this.pwdSalt = pwdSalt;
	}

	public String getPwdSalt() {
		return this.pwdSalt;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getPwd() {
		return this.pwd;
	}

	public void setPstnId(int pstnId) {
		this.pstnId = pstnId;
	}

	public int getPstnId() {
		return this.pstnId;
	}

	public void setJobId(int jobId) {
		this.jobId = jobId;
	}

	public int getJobId() {
		return this.jobId;
	}

	public void setDepId(String depId) {
		this.depId = depId;
	}

	public String getDepId() {
		return this.depId;
	}

	public int getLgnCnt() {
		return lgnCnt;
	}

	public void setLgnCnt(int lgnCnt) {
		this.lgnCnt = lgnCnt;
	}

	public String getFailDt() {
		return failDt;
	}

	public void setFailDt(String failDt) {
		this.failDt = failDt;
	}

	public EmpVO getCrtEmp() {
		return crtEmp;
	}

	public void setCrtEmp(EmpVO crtEmp) {
		this.crtEmp = crtEmp;
	}

	public EmpVO getMdfyEmp() {
		return mdfyEmp;
	}

	public void setMdfyEmp(EmpVO mdfyEmp) {
		this.mdfyEmp = mdfyEmp;
	}

	public DepVO getDep() {
		return dep;
	}

	public void setDep(DepVO dep) {
		this.dep = dep;
	}

	public JobVO getJob() {
		return job;
	}

	public void setJob(JobVO job) {
		this.job = job;
	}

	public PstnVO getPstn() {
		return pstn;
	}

	public void setPstn(PstnVO pstn) {
		this.pstn = pstn;
	}
	
}
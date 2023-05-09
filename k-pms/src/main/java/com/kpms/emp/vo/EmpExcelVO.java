package com.kpms.emp.vo;

import java.util.ArrayList;
import java.util.List;

import com.kpms.common.excel4j.annotations.ExcelSheet;
import com.kpms.common.excel4j.annotations.Field;
import com.kpms.common.excel4j.annotations.Format;
import com.kpms.common.excel4j.annotations.Title;
import com.kpms.common.util.StringUtil;

/**
 * EMP
 */
@ExcelSheet(value="Employees", useTitle = true)
public class EmpExcelVO{
	@Title("ID")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER, bold = true)
	private String empId;
	
	@Title("이름")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String nm;

	@Title(value = "생년월일")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String brthdy;
	
	@Title("이메일")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String eml;
	
	@Title("전화번호")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String phn;
	
	@Title(value = "입사일", date = true)
	@Format(dataFormat = "yyyy-MM-dd")
	private String hrDt;
	
	@Title("우편번호")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String pstCd;
	
	@Title("주소")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String addrss;

	@Title("상세 주소")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String dtlAddrss;

	@Title("재직상태")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String emplmntStts;
	
	@Title("직급")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String pstn;
	
	@Title("직무")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String job;
	
	@Title("부서")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String dep;

	public EmpExcelVO(EmpVO empVO) {
		this.empId = empVO.getEmpId();
		
		this.nm = empVO.getlNm() + empVO.getfNm();
		this.brthdy = empVO.getBrthdy();
		this.eml = empVO.getEml();
		this.phn = empVO.getPhn();
		this.hrDt = empVO.getHrDt();
		this.pstCd = empVO.getPstCd();
		this.addrss = empVO.getAddrss();
		String dtlAddrss = empVO.getDtlAddrss();
		if(StringUtil.isEmpty(dtlAddrss)) {
			dtlAddrss = "-";
		}
		this.dtlAddrss = dtlAddrss;
		
		this.emplmntStts = empVO.getEmplmntSttsVO().getCdNm();
		this.pstn = empVO.getPstn().getPstnNm();
		this.job = empVO.getJob().getJobNm();
		this.dep = empVO.getDep().getDepNm();
	}
	
	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getNm() {
		return nm;
	}

	public void setNm(String nm) {
		this.nm = nm;
	}

	public String getBrthdy() {
		return brthdy;
	}

	public void setBrthdy(String brthdy) {
		this.brthdy = brthdy;
	}

	public String getEml() {
		return eml;
	}

	public void setEml(String eml) {
		this.eml = eml;
	}

	public String getPhn() {
		return phn;
	}

	public void setPhn(String phn) {
		this.phn = phn;
	}

	public String getHrDt() {
		return hrDt;
	}

	public void setHrDt(String hrDt) {
		this.hrDt = hrDt;
	}

	public String getPstCd() {
		return pstCd;
	}

	public void setPstCd(String pstCd) {
		this.pstCd = pstCd;
	}

	public String getAddrss() {
		return addrss;
	}

	public void setAddrss(String addrss) {
		this.addrss = addrss;
	}

	public String getDtlAddrss() {
		return dtlAddrss;
	}

	public void setDtlAddrss(String dtlAddrss) {
		this.dtlAddrss = dtlAddrss;
	}

	public String getEmplmntStts() {
		return emplmntStts;
	}

	public void setEmplmntStts(String emplmntStts) {
		this.emplmntStts = emplmntStts;
	}

	public String getPstn() {
		return pstn;
	}

	public void setPstn(String pstn) {
		this.pstn = pstn;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getDep() {
		return dep;
	}

	public void setDep(String dep) {
		this.dep = dep;
	}

	public static List<String> getTitles() {
		List<String> titles = new ArrayList<>();
		titles.add("ID");
		titles.add("이름");
		titles.add("생년월일");
		titles.add("입사일");
		titles.add("우편번호");
		titles.add("주소");
		titles.add("상세주소");
		titles.add("재직상태");
		titles.add("직급");
		titles.add("직무");
		titles.add("부서");
		
		return titles;
	}
	
}
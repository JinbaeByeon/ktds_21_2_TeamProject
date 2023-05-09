package com.kpms.acslog.vo;

import com.kpms.common.excel4j.annotations.ExcelSheet;
import com.kpms.common.excel4j.annotations.Format;
import com.kpms.common.excel4j.annotations.Title;

/**
 * ACS_LOG
 */
@ExcelSheet(value="AcsLogs", useTitle = true)
public class AcsLogExcelVO{

	@Title("사원ID")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER, bold = true)
	private String empId;
	
	@Title("이름")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String nm;

	@Title("액세스 날짜")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String crtDt;
	
	@Title("액세스 기록")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String acsLog;
	
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
	public String getAcsLog() {
		return acsLog;
	}
	public void setAcsLog(String acsLog) {
		this.acsLog = acsLog;
	}
	public String getCrtDt() {
		return crtDt;
	}
	public void setCrtDt(String crtDt) {
		this.crtDt = crtDt;
	}

}
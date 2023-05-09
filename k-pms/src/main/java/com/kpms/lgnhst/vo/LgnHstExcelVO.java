package com.kpms.lgnhst.vo;

import com.kpms.common.excel4j.annotations.ExcelSheet;
import com.kpms.common.excel4j.annotations.Format;
import com.kpms.common.excel4j.annotations.Title;

/**
 * LGN_LOG
 */
@ExcelSheet(value="LgnLogs", useTitle = true)
public class LgnHstExcelVO{

	@Title("날짜")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String crtDt;
	
	@Title("사원ID")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER, bold = true)
	private String empId;
	
	@Title("이름")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String nm;

	@Title("로그인/로그아웃")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String act;
	
	@Title("IP")
	@Format(alignment = Format.LEFT, verticalAlignment = Format.V_CENTER)
	private String ip;

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

	public String getAct() {
		return act;
	}

	public void setAct(String act) {
		this.act = act;
	}

	public String getCrtDt() {
		return crtDt;
	}

	public void setCrtDt(String crtDt) {
		this.crtDt = crtDt;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}
	
}
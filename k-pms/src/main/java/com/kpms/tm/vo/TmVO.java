package com.kpms.tm.vo;

import java.util.List;

import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.dep.vo.DepVO;
import com.kpms.emp.vo.EmpVO;
import com.kpms.tmmbr.vo.TmMbrVO;

/**
 * TM
 */
public class TmVO extends AbstractPagingVO {

	private String tmId;
	private String tmNm;
	private String tmCrtDt;
	private String depId;
	private String tmHdId;
	
	private DepVO depIdDepVO;
	
	private List<TmMbrVO> tmMbrList;
	
	private TmMbrVO tmMbrVO;
	
	private EmpVO tmHdEmpVO;
	
	public String getTmId() {
		return tmId;
	}
	public void setTmId(String tmId) {
		this.tmId = tmId;
	}
	public String getTmNm() {
		return tmNm;
	}
	public void setTmNm(String tmNm) {
		this.tmNm = tmNm;
	}
	public String getTmCrtDt() {
		return tmCrtDt;
	}
	public void setTmCrtDt(String tmCrtDt) {
		this.tmCrtDt = tmCrtDt;
	}
	public String getDepId() {
		return depId;
	}
	public void setDepId(String depId) {
		this.depId = depId;
	}
	public String getTmHdId() {
		return tmHdId;
	}
	public void setTmHdId(String tmHdId) {
		this.tmHdId = tmHdId;
	}
	public DepVO getDepIdDepVO() {
		return depIdDepVO;
	}
	public void setDepIdDepVO(DepVO depIdDepVO) {
		this.depIdDepVO = depIdDepVO;
	}

	public List<TmMbrVO> getTmMbrList() {
		return tmMbrList;
	}
	public void setTmMbrList(List<TmMbrVO> tmMbrList) {
		this.tmMbrList = tmMbrList;
	}
	public TmMbrVO getTmMbrVO() {
		return tmMbrVO;
	}
	public void setTmMbrVO(TmMbrVO tmMbrVO) {
		this.tmMbrVO = tmMbrVO;
	}
	public EmpVO getTmHdEmpVO() {
		return tmHdEmpVO;
	}
	public void setTmHdEmpVO(EmpVO tmHdEmpVO) {
		this.tmHdEmpVO = tmHdEmpVO;
	}

}
package com.kpms.dep.vo;

import java.util.List;

import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.emp.vo.EmpVO;
import com.kpms.tm.vo.TmVO;

/**
 * DEP
 */
public class DepVO extends AbstractPagingVO {

	private String depId;
	private String depNm;
	private String depHdId;
	private String depCrtDt;
	
	private EmpVO crtrEmpVO;
	private EmpVO mdfyrEmpVO;
	private EmpVO hdNmEmpVO;
	private EmpVO tmNmEmpVO;
	
	private TmVO depIdTmVO;
	
	private List<TmVO> tmList;
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
	
	public EmpVO getCrtrEmpVO() {
		return crtrEmpVO;
	}
	public void setCrtrEmpVO(EmpVO crtrEmpVO) {
		this.crtrEmpVO = crtrEmpVO;
	}
	public EmpVO getMdfyrEmpVO() {
		return mdfyrEmpVO;
	}
	public void setMdfyrEmpVO(EmpVO mdfyrEmpVO) {
		this.mdfyrEmpVO = mdfyrEmpVO;
	}
	public EmpVO getHdNmEmpVO() {
		return hdNmEmpVO;
	}
	public void setHdNmEmpVO(EmpVO hdNmEmpVO) {
		this.hdNmEmpVO = hdNmEmpVO;
	}
	public EmpVO getTmNmEmpVO() {
		return tmNmEmpVO;
	}
	public void setTmNmEmpVO(EmpVO tmNmEmpVO) {
		this.tmNmEmpVO = tmNmEmpVO;
	}
	public TmVO getDepIdTmVO() {
		return depIdTmVO;
	}
	public void setDepIdTmVO(TmVO depIdTmVO) {
		this.depIdTmVO = depIdTmVO;
	}
	public List<TmVO> getTmList() {
		return tmList;
	}
	public void setTmList(List<TmVO> tmList) {
		this.tmList = tmList;
	}
	public List<EmpVO> getEmpList() {
		return empList;
	}
	public void setEmpList(List<EmpVO> empList) {
		this.empList = empList;
	}
	
	
	
}
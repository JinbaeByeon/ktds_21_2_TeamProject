package com.kpms.knw.vo;

import java.util.List;

import com.kpms.common.vo.AbstractFileVO;
import com.kpms.knwrpl.vo.KnwRplVO;
import com.kpms.prj.vo.PrjVO;

/**
 * KNW
 */
public class KnwVO extends AbstractFileVO {

	private String knwId;
	private String ttl;
	private String cntnt;
	private String vwCnt;
	private String prjId;

	private PrjVO prjVO; // 프로젝트에 대한 정보(프로젝트 이름, 상태)
	private List<KnwRplVO> rplList; // 지식관리 댓글

	public String getKnwId() {
		return knwId;
	}

	public void setKnwId(String knwId) {
		this.knwId = knwId;
	}

	public String getTtl() {
		return ttl;
	}

	public void setTtl(String ttl) {
		this.ttl = ttl;
	}

	public String getCntnt() {
		return cntnt;
	}

	public void setCntnt(String cntnt) {
		this.cntnt = cntnt;
	}

	public String getVwCnt() {
		return vwCnt;
	}

	public void setVwCnt(String vwCnt) {
		this.vwCnt = vwCnt;
	}

	public String getPrjId() {
		return prjId;
	}

	public void setPrjId(String prjId) {
		this.prjId = prjId;
	}

	public PrjVO getPrjVO() {
		return prjVO;
	}

	public void setPrjVO(PrjVO prjVO) {
		this.prjVO = prjVO;
	}

	public List<KnwRplVO> getRplList() {
		return rplList;
	}

	public void setRplList(List<KnwRplVO> rplList) {
		this.rplList = rplList;
	}


}
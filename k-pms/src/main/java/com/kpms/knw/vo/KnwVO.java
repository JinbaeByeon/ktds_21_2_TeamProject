package com.kpms.knw.vo;

import java.util.List;

import com.kpms.common.vo.AbstractVO;
import com.kpms.knwrpl.vo.KnwRplVO;

/**
 * KNW
 */
public class KnwVO extends AbstractVO {

	private String knwId;
	private String ttl;
	private String cntnt;
	private String vwCnt;
	private String prjId;

	private List<KnwRplVO> rplList;

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

	public List<KnwRplVO> getRplList() {
		return rplList;
	}

	public void setRplList(List<KnwRplVO> rplList) {
		this.rplList = rplList;
	}

}
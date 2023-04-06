package com.kpms.cmncd.vo;

import com.kpms.common.vo.AbstractVO;

/**
 * CMN_CD
 */
public class CmnCdVO extends AbstractVO {

	private String cdId;
	private String cdNm;
	private String prcdncCdId;


	public void setCdId(String cdId) {
		this.cdId = cdId;
	}

	public String getCdId() {
		return this.cdId;
	}

	public void setCdNm(String cdNm) {
		this.cdNm = cdNm;
	}

	public String getCdNm() {
		return this.cdNm;
	}

	public void setPrcdncCdId(String prcdncCdId) {
		this.prcdncCdId = prcdncCdId;
	}

	public String getPrcdncCdId() {
		return this.prcdncCdId;
	}

}
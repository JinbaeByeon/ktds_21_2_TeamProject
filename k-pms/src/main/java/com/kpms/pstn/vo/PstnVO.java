package com.kpms.pstn.vo;

import com.kpms.common.vo.AbstractPagingVO;
import com.kpms.common.vo.AbstractVO;

/**
 * PSTN
 */
public class PstnVO extends AbstractPagingVO{

	private int pstnId;
	private String pstnNm;

	public int getPstnId() {
		return pstnId;
	}

	public void setPstnId(int pstnId) {
		this.pstnId = pstnId;
	}

	public String getPstnNm() {
		return pstnNm;
	}

	public void setPstnNm(String pstnNm) {
		this.pstnNm = pstnNm;
	}

}	
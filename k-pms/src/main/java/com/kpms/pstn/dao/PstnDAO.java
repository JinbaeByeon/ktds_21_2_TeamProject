package com.kpms.pstn.dao;

import java.util.List;

import com.kpms.pstn.vo.PstnVO;

public interface PstnDAO {

	public int createNewPstn(PstnVO pstnVO);
	public List<PstnVO> readAllPstn(PstnVO pstnVO);
	public List<PstnVO> readAllPstnNoPagination(String pstnNm);
	public int updateNewPstn(PstnVO pstnVO);
	public int deletePstnByPstnId(int pstnId);
	public int deletePstnBySelectedPstnId(List<Integer> pstnId);
}

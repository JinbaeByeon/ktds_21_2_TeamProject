package com.kpms.pstn.service;

import java.util.List;

import com.kpms.pstn.vo.PstnVO;

public interface PstnService {
	
	public boolean createNewPstn(PstnVO pstnVO);
	public List<PstnVO> readAllPstn(PstnVO pstnVO);
	public boolean updateNewPstn(PstnVO pstnVO);
	public boolean deletePstnByPstnId(int pstnId);
	public boolean deletePstnBySelectedPstnId(List<Integer> pstnId);
}

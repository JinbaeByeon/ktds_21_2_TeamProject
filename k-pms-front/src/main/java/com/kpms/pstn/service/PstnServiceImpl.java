package com.kpms.pstn.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.common.exception.APIArgsException;
import com.kpms.pstn.dao.PstnDAO;
import com.kpms.pstn.vo.PstnVO;

@Service
public class PstnServiceImpl implements PstnService{
	
	@Autowired
	private PstnDAO pstnDAO;
	
	@Override
	public boolean createNewPstn(PstnVO pstnVO) {
		String pstnNm = pstnVO.getPstnNm();
		if(pstnNm == null || pstnNm == "") {
			throw new APIArgsException("404", "���޸��� �Է��ϼ���.");
		}
		return pstnDAO.createNewPstn(pstnVO) > 0;
	}

	@Override
	public List<PstnVO> readAllPstn(PstnVO pstnVO) {
		return pstnDAO.readAllPstn(pstnVO);
	}

	@Override
	public List<PstnVO> readAllPstnNoPagination(String pstnNm) {
		return pstnDAO.readAllPstnNoPagination(pstnNm);
	}
	
	@Override
	public boolean updateNewPstn(PstnVO pstnVO) {
		return pstnDAO.updateNewPstn(pstnVO) > 0;
	}

	@Override
	public boolean deletePstnByPstnId(int pstnId) {
		return pstnDAO.deletePstnByPstnId(pstnId) > 0;
	}

	@Override
	public boolean deletePstnBySelectedPstnId(List<Integer> pstnId) {
		return pstnDAO.deletePstnBySelectedPstnId(pstnId) > 0;
	}

	

}

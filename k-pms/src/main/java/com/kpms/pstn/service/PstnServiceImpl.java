package com.kpms.pstn.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.pstn.dao.PstnDAO;
import com.kpms.pstn.vo.PstnVO;

@Service
public class PstnServiceImpl implements PstnService{
	
	@Autowired
	private PstnDAO pstnDAO;
	
	@Override
	public boolean createNewPstn(PstnVO pstnVO) {
		return pstnDAO.createNewPstn(pstnVO) > 0;
	}

	@Override
	public boolean readPstnByPstnId(String pstnId) {
		return pstnDAO.readPstnByPstnId(pstnId) > 0;
	}

	@Override
	public List<PstnVO> readAllPstn(PstnVO pstnVO) {
		return pstnDAO.readAllPstn(pstnVO);
	}

	@Override
	public boolean updateNewPstn(PstnVO pstnVO) {
		return pstnDAO.updateNewPstn(pstnVO) > 0;
	}

	@Override
	public boolean deletePstnByPstnId(String pstnId) {
		return pstnDAO.deletePstnByPstnId(pstnId) > 0;
	}

}
